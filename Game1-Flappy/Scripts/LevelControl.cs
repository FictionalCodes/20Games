using Godot;
using System;

public partial class LevelControl : Node2D
{

    [Signal]
    public delegate void OnScoreUpdatedEventHandler(int newScore);
    float _obstacleSpeed = 150f;
    int _score = 0;

    [Export] 
    private PackedScene _obstacleList;

    [Export] private Node2D _obstacleSpawnPoint;

    Random _random = new Random();

    [Export] Timer _spawnTimer;
    [Export] private ParallaxBackground background;

    private NodePool<PipeControl> _pipePool;

public LevelControl() :base()
{
    
}
    public override void _Ready()
    {
        base._Ready();
        GD.Print($"Creating Level Control");

        _pipePool = new NodePool<PipeControl>(_obstacleList);
    }


    public override void _Process(double delta)
    {
        base._Process(delta);
        background.ScrollOffset -= new Vector2(_obstacleSpeed* (float)delta, 0);
    }

    public void OnObstacleCollision()
    {
        GetTree().Paused = true;
    }

    public void OnObstacleCollisionDirect(Node node)
    {
        GD.Print($"The Object that killed the game is {node.Name}");
        GetTree().Paused = true;
    }



    public void OnPointArea()
    {
        _score++;
        EmitSignal(SignalName.OnScoreUpdated, _score);
    }

    public void SpawnPipe()
    {
        GD.Print("Spawning Pipe");

        var pipe = _pipePool.GetPooledItem();
        AddChild(pipe);
        pipe.GlobalPosition = _obstacleSpawnPoint.GlobalPosition;
        pipe.ObstacleSpeed = _obstacleSpeed;
        pipe.BindEvents(OnObstacleCollision, OnPointArea);
        pipe.RandomiseObstacle(_random, _score);
        var nextSpawnDelay = (_random.NextDouble() * 5.0) - Math.Max(_score / 100.0, 1.0);
        _spawnTimer.WaitTime = Math.Clamp(nextSpawnDelay, 2.0, 5.0);
    }

}
