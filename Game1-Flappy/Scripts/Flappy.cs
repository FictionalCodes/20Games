using Godot;

public partial class Flappy : RigidBody2D
{
    [Export]
    private float _pushSpeed;

    [Export] private GpuParticles2D _trailParticles;
    [Export] private GpuParticles2D _pushParticles;

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

    }

    public void StartLife(Vector2 startPosition)
    {
        this.GlobalPosition = startPosition;
        _trailParticles.Emitting = true;
        Visible = true;
        ProcessMode = ProcessModeEnum.Inherit;
    }

    public void EndLife()
    {
        _trailParticles.Emitting = false;
        _trailParticles.Restart();
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
