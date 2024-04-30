using Godot;

public partial class MainMenuControl : Control
{
    [Export] CanvasLayer mainMenuLayer;
    [Export] OptionsController optionsMenuLayer;
    [Export] Label _highscoreLabel;
    private SettingsManager _settingsBindings;


    public void ChangeToGameScene()
    {
        GetTree().ChangeSceneToFile("res://GameScenes/BaseScene.tscn");
    }

    public override void _Ready()
    {
        base._Ready();
        _settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");
        _highscoreLabel.Text = _settingsBindings.HighScore.ToString("00000");

    }

    public void ToggleMenu(bool useOptions)
    {
        mainMenuLayer.Visible = !useOptions;
        if(useOptions)
        {
            optionsMenuLayer.OpenOptions();
        }
        else
        {
            optionsMenuLayer.CloseOptions();
        }
    }
}
