using Godot;
using System;
using System.Diagnostics;
public partial class PipeControl : Node2D
{
    [Export] Node2D _upperZone;
    [Export] Node2D _lowerZone;

    [Signal]
    public delegate void PointGotEventHandler();
    [Signal]
    public delegate void ObstacleHitEventHandler();
    public float ObstacleSpeed{get;set;}

    private const int MinDistanceSeperation = 100;
    private const int MaxDistanceSeperation = 400;

    private Vector2 _moveVector;
    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
	{
        base._Process(delta);
        float fDelta = (float)delta;
        GlobalTranslate(Vector2.Left * ObstacleSpeed * fDelta);
	}

    public void PipeHit(Node2D other)
    {
        EmitSignal(SignalName.ObstacleHit);
    }

    public void PointGet(Node2D other)
    {
        EmitSignal(SignalName.PointGot);
    }

    public void BindEvents(ObstacleHitEventHandler onObstacleCollision, PointGotEventHandler onPointArea)
    {
        ObstacleHit += onObstacleCollision;
        PointGot += onPointArea;
    }

    public void RandomiseObstacle(Random random, int randomisationFactor)
    {
        randomisationFactor = Math.Max(MinDistanceSeperation, MaxDistanceSeperation - randomisationFactor);
        var seperationAmount = random.Next(MinDistanceSeperation, randomisationFactor);
        var viewportSize = GetViewportRect().Size;

        var positionVariance = random.Next(MinDistanceSeperation, (int)viewportSize.Y - MinDistanceSeperation);
        var currentPosition = GlobalPosition;
        currentPosition.Y = positionVariance;
        GlobalPosition = currentPosition;

        _upperZone.Position += Vector2.Up * seperationAmount/2;
        _lowerZone.Position += Vector2.Down * seperationAmount/2;

    }

    public void ExitScreen()
    {
        this.QueueFree();
        GD.Print("Removing Pipe");
    }

}
