using Godot;
using System;

public partial class MainMenuControl : Control
{

    public void ChangeToGameScene()
    {
        GetTree().ChangeSceneToFile("res://GameScenes/BaseScene.tscn");
    }
}
