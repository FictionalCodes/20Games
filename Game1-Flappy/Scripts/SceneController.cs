using Godot;
using System;

public partial class SceneController : Node2D
{
    [Export] LevelControl _levelController;
    [Export] PopupMenuController _menuOverlay;

    public void TogglePause()
    {
        var tree = GetTree();
        var currentState = tree.Paused;

        tree.Paused = !currentState;

        _menuOverlay.ActivatePaused();
        _menuOverlay.Visible = !currentState;
    }

    public void StartLife()
    {
        GD.Print("Got to the SceneController");
        _levelController.BeginSpawning();
        _menuOverlay.Visible = false;
    }

    internal void EndOfLife()
    {
        _menuOverlay.ActivateEndOfLife();
    }

    public void GoToMainMenu()
    {
        GetTree().ChangeSceneToFile("res://GameScenes/BaseScene.tscn");
    }
}
