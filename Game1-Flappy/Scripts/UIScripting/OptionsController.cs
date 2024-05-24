using Godot;

public partial class OptionsController : CanvasLayer
{
    private SettingsManager _settingsBindings;

    private SettingsBinder _binder;
    [Signal] public delegate void WindowClosedEventHandler();


    public override void _Ready()
    {
        base._Ready();

        _settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");
        _binder = GetNode<SettingsBinder>("Binder");

    }

    public void OpenOptions()
    {
        _binder.SetupValues();
        this.Visible = true;
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
