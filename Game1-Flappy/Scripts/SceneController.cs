using Godot;

public partial class SceneController : Node2D
{
    [Export] LevelControl _levelController;
    [Export] PopupMenuController _menuOverlay;
    private SettingsManager _settingsBindings;


    public void TogglePause()
    {
        var tree = GetTree();
        var currentState = tree.Paused;

        tree.Paused = !currentState;

        _menuOverlay.ActivatePaused();
        _menuOverlay.Visible = !currentState;

        _settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");

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
