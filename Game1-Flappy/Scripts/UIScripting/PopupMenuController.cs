using Godot;

public partial class PopupMenuController : OverlayController
{
    [Export] Label _menuTitleLabel;

    [Export] Button _resumeButton;

    [Export] CanvasLayer _optionsMenu;


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

    public void OpenOptions(bool enabled)
    {
        this.Visible = !enabled;
        _optionsMenu.Visible = enabled;
    }

}
