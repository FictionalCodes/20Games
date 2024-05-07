using Game1flappy.Scripts.Globals.ConfigurationObjects;
using Godot;
using System;

public partial class MenuBackground : ParallaxBackground
{
    private SettingsManager _settingsBindings;
    [Export] private CanvasModulate _lightingFilter;

    public override void _Ready()
    {
        base._Ready();
        _settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");

        _settingsBindings.LightingOnChange += OnLightingChange;

    }

    private void OnLightingChange(LightingSettings settings)
    {
        _lightingFilter.Visible = !settings.DynamicLightingEnabled;
    }
    // Called every frame. 'delta' is the elapsed time since the previous frame.
    public override void _Process(double delta)
	{
        this.ScrollOffset += Vector2.Left;
	}
}
