using Godot;

public partial class OptionsController : CanvasLayer
{
    [Export] Slider _musicVolumeControl;
    [Export] Slider _fxVolumeControl;

    [Export] BaseButton _particlesOnOff;
    [Export] BaseButton _lightingOnOff;
    private SettingsManager _settingsBindings;

    [Signal] public delegate void WindowClosedEventHandler();


    public override void _Ready()
    {
        base._Ready();

        _settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");
        _musicVolumeControl.Value = _settingsBindings.MusicVolume;
        _fxVolumeControl.Value = _settingsBindings.FxVolume;
        _particlesOnOff.SetPressedNoSignal(_settingsBindings.ParticlesOn);
        _lightingOnOff.SetPressedNoSignal(_settingsBindings.LightingOn);


    }

    public void UpdateMusicVolume(bool valueChanged)
    {
        if (valueChanged) _settingsBindings.MusicVolume = (float)_musicVolumeControl.Value;
    }
    public void UpdateFxVolume(bool valueChanged)
    {
        if (valueChanged) _settingsBindings.FxVolume = (float)_fxVolumeControl.Value;
    }

    public void ParticlesToggled(bool checkedValue) => _settingsBindings.ParticlesOn = checkedValue;
    public void LightingToggle(bool checkedValue) => _settingsBindings.LightingOn = checkedValue;

    public void EnableWindow(bool enabled)
    {
        Visible = enabled;
        EmitSignal(SignalName.WindowClosed);
    }
}
