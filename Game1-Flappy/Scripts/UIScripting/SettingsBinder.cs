using Game1flappy.Scripts.Globals.ConfigurationObjects;
using Godot;

public partial class SettingsBinder : Node
{
    private SettingsManager _settingsBindings;

    [Export] CheckBox _particlesOnOff;
    [Export] CheckBox _trailPartlesCheck;
    [Export] CheckBox _bouncePartlesCheck;
    [Export] OptionButton _particleQuantityDropdown;

    [Export] CheckBox _lightingOnOff;
    [Export] OptionButton _shadowQualityDropdown;

    [Export] private Slider _musicVolumeSlider;
    [Export] private Slider _FXVolumeSlider;



    public override void _Ready()
    {
        _settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");
        base._Ready();
    }

    public void SetupValues()
    {
        _particlesOnOff.SetPressedNoSignal(_settingsBindings.ParticleSettings.ParticlesEnabledGlobal);
        _trailPartlesCheck.SetPressedNoSignal(_settingsBindings.ParticleSettings.TrailEnabled);
        _bouncePartlesCheck.SetPressedNoSignal(_settingsBindings.ParticleSettings.BounceEnabled);
        _particleQuantityDropdown.Select((int)_settingsBindings.ParticleSettings.Quantity);

        _lightingOnOff.SetPressedNoSignal(_settingsBindings.LightingSettings.DynamicLightingEnabled);
        _shadowQualityDropdown.Select((int)_settingsBindings.LightingSettings.ShadowQualityValue);

        _musicVolumeSlider.SetValueNoSignal(_settingsBindings.SoundSettings.MusicVolume);
        _FXVolumeSlider.SetValueNoSignal(_settingsBindings.SoundSettings.FXVolume);

    }

    public void SetMusicVolumeNumber(float number) =>
        _settingsBindings.SoundSettings.MusicVolume = number;
    public void SetFXVolumeNumber(float number) =>
        _settingsBindings.SoundSettings.FXVolume = number;
    public void SetParticlesOn(bool onOff){
        _settingsBindings.ParticleSettings.ParticlesEnabledGlobal = onOff;
    }

    public void SetTrailParticles(bool onOff) => _settingsBindings.ParticleSettings.TrailEnabled = onOff;
    public void SetBounceParticles(bool onOff) => _settingsBindings.ParticleSettings.BounceEnabled = onOff;
    public void SetParticleQuantity(int particleSelection) => _settingsBindings.ParticleSettings.Quantity = (ParticleSettings.ParticleQuantity)(ushort)particleSelection;

    public void SetLightingEnabled(bool onOff) => _settingsBindings.LightingSettings.DynamicLightingEnabled = onOff;
    public void SetLightingQuantity(int lightingSelection) =>
        _settingsBindings.LightingSettings.ShadowQualityValue = (LightingSettings.ShadowQuality) lightingSelection;


}
