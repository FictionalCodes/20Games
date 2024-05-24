using Game1flappy.Scripts.Globals.ConfigurationObjects;
using Godot;
using System;

public partial class GameBackground : ParallaxBackground
{
    private SettingsManager _settingsBindings;
    private CanvasModulate _lightingFilter;

    public override void _Ready()
    {
        base._Ready();
        _lightingFilter = GetNode<CanvasModulate>("CanvasModulate");
        _settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");

        _settingsBindings.LightingOnChange += OnLightingChange;

    }

    private void OnLightingChange(LightingSettings settings)
    {

        _lightingFilter.Visible = settings.DynamicLightingEnabled;
    }
    // Called every frame. 'delta' is the elapsed time since the previous frame.
    
}
