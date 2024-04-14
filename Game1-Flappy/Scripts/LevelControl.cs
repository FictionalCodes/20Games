using Game1flappy.Scripts.Utils;
using Godot;
using System;

public partial class LevelControl : Node2D
{

    [Export] Timer _spawnTimer;
    [Export] private ParallaxBackground background;
    [Export] private PackedScene _obstacleList;
    [Export] private Node2D _obstacleSpawnPoint;
    [Export] private Node2D _playerSpawnPoint;
    [Export] private Flappy _playerObject;

    [Export] private CanvasLayer _menuOverlay;
    float _obstacleSpeed = 150f;
    public float ObstacleSpeed => _obstacleSpeed;
    int _score = 0;
    readonly Random _random = new();
    private NodePool<PipeControl> _pipePool;

    [Signal]
    public delegate void OnScoreUpdatedEventHandler(int newScore);


    public LevelControl() :base()
{
    
}
    public override void _Ready()
    {
        base._Ready();
        GD.Print($"Creating Level Control");

        _pipePool = new NodePool<PipeControl>(_obstacleList, "obstacle");

        StartLife();
    }


    public override void _Process(double delta)
    {
        base._Process(delta);
        background.ScrollOffset -= new Vector2(_obstacleSpeed* (float)delta, 0);
    }

    public void StartLife()
    {
        _pipePool.ForceAllObjectsDespawn();
        _spawnTimer.WaitTime = 0.1f;
        _spawnTimer.Start();
        _playerObject.StartLife(_playerSpawnPoint.GlobalPosition);
        _menuOverlay.Visible = false;
        _score = 0;
        EmitSignal(SignalName.OnScoreUpdated, _score);

    }

    public void OnObstacleCollision()
    {
        CallDeferred(MethodName.EndOfLife);
    }

    public void OnObstacleCollisionDirect(Node node)
    {
        GD.Print($"The Object that killed the game is {node.Name}");
        
        CallDeferred(MethodName.EndOfLife);
    }

    public void EndOfLife()
    {

        _spawnTimer.Stop();
        _playerObject.EndLife();
        _menuOverlay.Visible = true;
    }

    public void OnPointArea()
    {
        _score++;
        EmitSignal(SignalName.OnScoreUpdated, _score);
    }

    public void SpawnPipe()
    {


        var pipe = _pipePool.GetNextAvalibleItem();

        AddChild(pipe);

        GD.Print($"Spawning Pipe - {pipe.Name}");

        pipe.Setup(_obstacleSpawnPoint.GlobalPosition, _obstacleSpeed);
        pipe.BindEvents(OnObstacleCollision, OnPointArea);
        pipe.RandomiseObstacle(_random, _score);
        var nextSpawnDelay = (_random.NextDouble() * 5.0) - Math.Max(_score / 100.0, 1.0);
        _spawnTimer.WaitTime = Math.Clamp(nextSpawnDelay, 2.0, 5.0);
        _spawnTimer.Start();
    }

    public void TogglePause()
    {
        var tree = GetTree();
        var currentState = tree.Paused;

        tree.Paused = !currentState;


    }


}
