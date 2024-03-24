using Godot;
using System;
using System.Threading;

public partial class Flappy : RigidBody2D
{
    [Export]
    private float _pushSpeed;

    private bool _flapPending; 

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
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
    }

    public override void _UnhandledInput(InputEvent @event)
    {
        if (@event is InputEventScreenTouch touch)
        {
            if(touch.Pressed)
            {

                _flapPending = true;
            }
        }
            
    }

    
    public void Flap()
    {
        GD.Print("Flap");
        SetAxisVelocity(Vector2.Up * _pushSpeed);
    }
}
