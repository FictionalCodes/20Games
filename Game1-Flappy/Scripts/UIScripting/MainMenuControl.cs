using Godot;
using Godot.Collections;

public partial class MainMenuControl : Control
{
    [Export] CanvasLayer mainMenuLayer;
    [Export] OptionsController optionsMenuLayer;
    [Export] Label _highscoreLabel;

    [Export] AudioStreamPlayer _menuEffectPlayer;
    private SettingsManager _settingsBindings;

    public void ChangeToGameScene()
    {
        GetTree().ChangeSceneToFile("res://GameScenes/BaseScene.tscn");
    }

    public override void _Ready()
    {
        _settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");
        _highscoreLabel.Text = _settingsBindings.HighScore.ToString("00000");

       var allChildren = FindChildren("*", "Control");

       foreach(var control in allChildren)
       {
            if(control is BaseButton button)
            {
                button.ButtonDown += () => _menuEffectPlayer.Play(); 
            }
            else if(control is Slider slider)
            {
                slider.ValueChanged += (_) => _menuEffectPlayer.Play();
            }
       }

        base._Ready();
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
