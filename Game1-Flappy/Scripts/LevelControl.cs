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

    [Export] AnimationPlayer _animatorPlayer;


    float _obstacleSpeed = 150f;
    public float ObstacleSpeed => _obstacleSpeed;

    public int Score { get => _score; }


    private int _score = 0;
    readonly Random _random = new();
    private SceneController _sceneController;

    private NodePool<PipeControl> _pipePool;

    [Signal]
    public delegate void OnScoreUpdatedEventHandler(int newScore);


    public LevelControl() :base()
    {
        
    }
    public override void _Ready()
    {
        base._Ready();

        _sceneController = GetParent<SceneController>();

        _pipePool = new NodePool<PipeControl>(_obstacleList, "obstacle");

        BeginSpawning();
    }


    public override void _Process(double delta)
    {
        base._Process(delta);
        background.ScrollOffset -= new Vector2(_obstacleSpeed* (float)delta, 0);
    }

    public void BeginSpawning()
    {
        _spawnTimer.Stop();

        _pipePool.ForceAllObjectsDespawn();
        _score = 0;
        EmitSignal(SignalName.OnScoreUpdated, _score);
        GetTree().Paused = false;
        _animatorPlayer.Play("NewLifeCountdown");
        _animatorPlayer.Active = true;

        CallDeferred(MethodName.SpawnSetupPlayer);


    }

    public void SpawnSetupPlayer()
    {
        _playerObject.SpawnSetup(_playerSpawnPoint.GlobalPosition);
    }

    public void SpawningCompleted()
    {
        _spawnTimer.Start(0.1f);

        _playerObject.BeginLife();
    }

    public void OnObstacleCollision()
    {
        CallDeferred(MethodName.EndOfLife);
    }

    public void OnObstacleCollisionDirect(Node node)
    {
        
        CallDeferred(MethodName.EndOfLife);
    }

    public void EndOfLife()
    {
        _spawnTimer.Stop();
        _playerObject.EndLife();

        _sceneController.EndOfLife();
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

        pipe.Setup(_obstacleSpawnPoint.GlobalPosition, _obstacleSpeed);
        pipe.BindEvents(OnObstacleCollision, OnPointArea);
        pipe.RandomiseObstacle(_random, _score);
        var nextSpawnDelay = (_random.NextDouble() * 5.0) - Math.Max(_score / 100.0, 1.0);
        _spawnTimer.WaitTime = Math.Clamp(nextSpawnDelay, 2.0, 5.0);
        _spawnTimer.Start();
    }
}
