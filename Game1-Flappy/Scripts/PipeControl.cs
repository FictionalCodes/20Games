using Game1flappy.Scripts.Utils;
using Godot;
using System;
using System.Diagnostics;
using System.Reflection;
public partial class PipeControl : Node2D, IPooledNode
{
    [Export] Node2D _upperZone;
    [Export] Node2D _lowerZone;

    public delegate void PointGotEventHandler();
    public delegate void ObstacleHitEventHandler();
    public float ObstacleSpeed{get;set;}
    public ObstacleHitEventHandler ObstacleHit { get; private set; }

    public PointGotEventHandler PointGot { get; private set; }

    [Export] private LightOccluder2D[] _shadowCasters{get;set;}


    private const int MinDistanceSeperation = 150;
    private const int MaxDistanceSeperation = 400;

    private bool _enteredScreen;

    private Vector2 _moveVector;
    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
	{
        base._Process(delta);
        float fDelta = (float)delta;
        GlobalTranslate(Vector2.Left * ObstacleSpeed * fDelta);

        var settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");

        settingsBindings.LightingOnChange += LightingOnOff;
        LightingOnOff(settingsBindings.LightingOn);

	}

    private void LightingOnOff(bool enabled)
    {
        foreach(var caster in _shadowCasters)
        {
            caster.Visible = enabled;
        }
    }


    public void PipeHit(Node2D other)
    {
        ObstacleHit();
    }

    public void PointGet(Node2D other)
    {
        PointGot();
    }

    public void BindEvents(ObstacleHitEventHandler onObstacleCollision, PointGotEventHandler onPointArea)
    {
        ObstacleHit = onObstacleCollision;
        PointGot = onPointArea;
        
    }

    public void RandomiseObstacle(Random random, int randomisationFactorInput)
    {
        var viewportSize = GetViewportRect().Size;
        var positionVariance = random.Next(MinDistanceSeperation, (int)viewportSize.Y - MinDistanceSeperation);
        var currentPosition = GlobalPosition;
        currentPosition.Y = positionVariance;
        GlobalPosition = currentPosition;

        var minRandomisationThisSet = Math.Max(MinDistanceSeperation + (MinDistanceSeperation - randomisationFactorInput), MinDistanceSeperation);
        var randomisationMax = Math.Max(minRandomisationThisSet, MaxDistanceSeperation - randomisationFactorInput);
        var seperationAmount = random.Next(minRandomisationThisSet, randomisationMax);


        _upperZone.Position = Vector2.Up * seperationAmount/2;
        _lowerZone.Position = Vector2.Down * seperationAmount/2;
    }

    public void EnterScreen()
    {
        _enteredScreen = true;
    }

    public void ExitScreen()
    {
        GetParent().RemoveChild(this);
        _enteredScreen = false;

        ObstacleHit = null;
        PointGot = null;
    }

    public void Setup(Vector2 globalPosition, float obstacleSpeed)
    {
        GlobalPosition = globalPosition;
        ObstacleSpeed = obstacleSpeed;
    }

    public void SpawnIn()
    {
    }

    public void DespawnOut()
    {
        ExitScreen();
    }

}
