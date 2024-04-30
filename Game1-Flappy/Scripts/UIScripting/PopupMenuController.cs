using Godot;

public partial class PopupMenuController : OverlayController
{
    [Export] Label _menuTitleLabel;

    [Export] Button _resumeButton;

    [Export] OptionsController _optionsMenu;


    public void ActivatePaused()
    {
        _resumeButton.Visible = true;
        _menuTitleLabel.Text = "Paused";

        this.Visible = true;
    }

    public void ActivateEndOfLife()
    {
        _resumeButton.Visible = false;
        _menuTitleLabel.Text = "Final Score";

        this.Visible = true;
    }

    public void ChangeToMenuScene()
    {
        GetTree().ChangeSceneToFile("res://GameScenes/menuscene.tscn");
    }

    public void OpenOptions()
    {
        this.Visible = false;
        _optionsMenu.OpenOptions();
    }

}
