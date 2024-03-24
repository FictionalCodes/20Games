using Godot;
using System;

public partial class LevelControl : Node2D
{

    [Signal]
    public delegate void OnScoreUpdatedEventHandler(int newScore);
    float _obstacleSpeed = 150f;
    int _score = 0;

    [Export] 
    private PackedScene[] _obstacleList;

    [Export] private Node2D _obstacleSpawnPoint;


    Random _random = new Random{};

    [Export] Timer _spawnTimer;


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
        var sceneToSpawn = _obstacleList[_random.Next(_obstacleList.Length)];
        var pipe = sceneToSpawn.Instantiate<PipeControl>();
        AddChild(pipe);
        pipe.GlobalPosition = _obstacleSpawnPoint.GlobalPosition;
        pipe.ObstacleSpeed = _obstacleSpeed;
        pipe.BindEvents(OnObstacleCollision, OnPointArea);
        pipe.RandomiseObstacle(_random, _score);
        var nextSpawnDelay = (_random.NextDouble() * 5.0) - Math.Max(_score / 100.0, 1.0);
        _spawnTimer.WaitTime = Math.Clamp(nextSpawnDelay, 2.0, 5.0);
    }

}
