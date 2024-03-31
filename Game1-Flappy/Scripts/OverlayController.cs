using Godot;
using System;

public partial class OverlayController : CanvasLayer
{

    [Export] Label _scoreText;
    public void ScoreUpdated(int newScore)
    {
        _scoreText.Text = newScore.ToString("00000");
    }
}
