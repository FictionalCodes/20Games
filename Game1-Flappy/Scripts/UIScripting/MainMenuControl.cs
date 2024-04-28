using Godot;

public partial class MainMenuControl : Control
{
    [Export] CanvasLayer mainMenuLayer;
    [Export] CanvasLayer optionsMenuLayer;
    public void ChangeToGameScene()
    {
        GetTree().ChangeSceneToFile("res://GameScenes/BaseScene.tscn");
    }

    public void ToggleMenu(bool useOptions)
    {
        mainMenuLayer.Visible = !useOptions;
        optionsMenuLayer.Visible = useOptions;
    }
}
