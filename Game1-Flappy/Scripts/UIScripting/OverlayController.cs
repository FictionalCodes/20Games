using Godot;
using System;

public partial class OverlayController : CanvasLayer
{

    [Export] protected Label _scoreText;
    public void ScoreUpdated(int newScore)
    {
        GD.Print(_scoreText);
        _scoreText.Text = newScore.ToString("00000");
    }
}
