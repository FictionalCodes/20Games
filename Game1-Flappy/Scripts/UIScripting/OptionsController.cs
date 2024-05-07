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
    }

    public void OpenOptions()
    {
    }

    public void UpdateMusicVolume(bool valueChanged)
    {
    }
    public void UpdateFxVolume(bool valueChanged)
    {
    }

    public void CloseButtonPress()
    {
        CloseOptions();
        EmitSignal(SignalName.WindowClosed);
    }

    public void CloseOptions()
    {
        Visible = false;
        _settingsBindings.SaveConfiguration();
    }
}
