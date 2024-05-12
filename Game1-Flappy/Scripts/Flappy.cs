using System;
using Game1flappy.Scripts.Globals.ConfigurationObjects;
using Godot;

public partial class Flappy : RigidBody2D
{
    [Export]
    private float _pushSpeed;

    [Export] private GpuParticles2D _trailParticles;
    [Export] private GpuParticles2D _pushParticles;
    [Export] private Light2D _shadowEmitter;
    [Export] private Light2D _textureLight;

    [Export] private AudioStreamPlayer _effectPlayer;

    private bool _flapPending;
    private bool _canPushParticles = true;
    private ShaderMaterial _trailMaterial;
    private LevelControl _control;

    // Called when the node enters the scene tree for the first time.


    public override void _Ready()
	{
        _control = GetParent<LevelControl>();
        _pushParticles.Finished += () => _canPushParticles = true;

        _trailMaterial = (ShaderMaterial)_trailParticles.ProcessMaterial;

        var settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");

        settingsBindings.ParticlesOnChange += ParticlesSettingsChanged;
        settingsBindings.LightingOnChange += LightingSettingsChanged;
        ParticlesSettingsChanged(settingsBindings.ParticleSettings);
        LightingSettingsChanged(settingsBindings.LightingSettings);
    }

    private void LightingSettingsChanged(LightingSettings settings)
    {
        _shadowEmitter.Enabled = settings.DynamicLightingEnabled;
        _textureLight.Enabled = settings.DynamicLightingEnabled;
        if(settings.DynamicLightingEnabled)
        {
            var quality = settings.GetMappedValue(settings.ShadowQualityValue);
            _shadowEmitter.ShadowEnabled = quality.HasValue;
            if (quality.HasValue)
            {
                _shadowEmitter.ShadowFilter = quality.Value;
            }
        }

    }

    private void ParticlesSettingsChanged(ParticleSettings settings)
    {
        _pushParticles.Visible = settings.ParticlesEnabledGlobal && settings.BounceEnabled;
        _trailParticles.Visible = settings.ParticlesEnabledGlobal && settings.TrailEnabled;

        var particleNumber = settings.GetParticleQuanityValue(settings.Quantity);
        _pushParticles.Amount = particleNumber/2;
        _trailParticles.Amount = particleNumber;
    }


    public void SpawnSetup(Vector2 startPosition)
    {
        //LightingSettingsChanged()
        ProcessMode = ProcessModeEnum.Disabled;

        Visible = true;
        LinearVelocity = Vector2.Zero;
        this.GlobalPosition = startPosition;
        _trailParticles.Restart();
        _trailParticles.Emitting = true;

        

    }

    public void BeginLife()
    {
        ProcessMode = ProcessModeEnum.Pausable;
    }

    public void EndLife()
    {
        //SetAxisVelocity(Vector2.Zero);

        _trailParticles.Emitting = false;
        Visible = false;
        ProcessMode = ProcessModeEnum.Disabled;
    }

    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _PhysicsProcess(double delta)
    {
        base._PhysicsProcess(delta);

        if(_flapPending)
        {
            Flap();
            _flapPending = false;
        }

        var trailAngle = Mathf.Atan2( Mathf.Clamp(this.LinearVelocity.Y, -_control.ObstacleSpeed, _control.ObstacleSpeed), _control.ObstacleSpeed *2);
        
        _trailMaterial.SetShaderParameter("direction", Vector2.FromAngle(trailAngle));
    }

    public override void _UnhandledInput(InputEvent @event)
    {
        if (@event is InputEventScreenTouch touch)
        {
            if(touch.Pressed && !GetViewport().IsInputHandled())
            {
                _flapPending = true;
            }
        }

        base._UnhandledInput(@event);
    }


    public void Flap()
    {
        SetAxisVelocity(Vector2.Up * _pushSpeed);
        if(_canPushParticles)
        {
            _pushParticles.Emitting = true;
            _canPushParticles = false;
        }

        _effectPlayer.Play();
    }
}
