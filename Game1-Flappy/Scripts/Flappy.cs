using System;
using Godot;

public partial class Flappy : RigidBody2D
{
    [Export]
    private float _pushSpeed;

    [Export] private GpuParticles2D _trailParticles;
    [Export] private GpuParticles2D _pushParticles;
    [Export] private Light2D _shadowEmitter;

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

        settingsBindings.ParticlesOnChange += ParticlesOnOff;
        settingsBindings.LightingOnChange += LightingOnOff;
        LightingOnOff(settingsBindings.LightingOn);
        ParticlesOnOff(settingsBindings.ParticlesOn);

    }

    private void LightingOnOff(bool enabled)
    {
        _shadowEmitter.ShadowEnabled = enabled;
    }


    private void ParticlesOnOff(bool enabled)
    {
        _pushParticles.Visible = enabled;
        _trailParticles.Visible = enabled;

    }


    public void SpawnSetup(Vector2 startPosition)
    {
        GD.Print("Re-setting Star");
        ProcessMode = ProcessModeEnum.Disabled;

        Visible = true;
        LinearVelocity = Vector2.Zero;
        this.GlobalPosition = startPosition;
        _trailParticles.Restart();
        _trailParticles.Emitting = true;

    }

    public void BeginLife()
    {
        GD.Print("Activating Star");
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
                GD.Print("FlapCheck");

                _flapPending = true;
                //GetViewport().SetInputAsHandled();
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
    }
}
