using System;
using Game1flappy.Scripts.Globals.ConfigurationObjects;
using Godot;

public partial class SceneController : Node2D
{
    [Export] LevelControl _levelController;
    [Export] PopupMenuController _menuOverlay;
    [Export] CanvasModulate _lightingFilter;
    private SettingsManager _settingsBindings;

    public override void _Ready()
    {
        _settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");

        _settingsBindings.LightingOnChange += OnLightingChange;
        OnLightingChange(_settingsBindings.LightingSettings);
    }

    public void TogglePause()
    {
        var tree = GetTree();
        var currentState = tree.Paused;

        tree.Paused = !currentState;

        _menuOverlay.ActivatePaused();
        _menuOverlay.Visible = !currentState;

    }

    private void OnLightingChange(LightingSettings settings)
    {
        //GD.Print($"Lighting Enabled = {settings.DynamicLightingEnabled}");
        _lightingFilter.Visible = settings.DynamicLightingEnabled;
        //GD.Print($"_lightingFilter Visible = {_lightingFilter.Visible}");

    }


    public void StartLife()
    {
        GD.Print("Got to the SceneController");
        _levelController.BeginSpawning();
        _menuOverlay.Visible = false;
    }

    internal void EndOfLife()
    {

        if(_levelController.Score > _settingsBindings.HighScore)
        {
            _settingsBindings.HighScore = _levelController.Score;
            _settingsBindings.SaveConfiguration();
        }
        _menuOverlay.ActivateEndOfLife();
    }

    public void GoToMainMenu()
    {
        GetTree().ChangeSceneToFile("res://GameScenes/menuscene.tscn");
    }
}
