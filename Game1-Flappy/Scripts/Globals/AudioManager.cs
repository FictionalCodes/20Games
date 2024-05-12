using Game1flappy.Scripts.Globals.ConfigurationObjects;
using Godot;

public partial class AudioManager : Node
{
    private int _musicBusIndex;
    private int _fxBusIndex;


    public override void _Ready()
    {
        base._Ready();

        _musicBusIndex = AudioServer.GetBusIndex("Music");
        _fxBusIndex = AudioServer.GetBusIndex("SoundEffect");

        var settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");
        settingsBindings.SoundOnChange += UpdateVolumes;
        UpdateVolumes(settingsBindings.SoundSettings);
    }

    private void UpdateVolumes(SoundSettings settings)
    {


        UpdateMusicVolume(settings.MusicVolume);
        UpdateFXVolume(settings.FXVolume);
    }

    //-50-0 as reference range 
    public void UpdateMusicVolume(float amout) => UpdateAudioBusVolume(_musicBusIndex, amout);
    public void UpdateFXVolume(float amout) => UpdateAudioBusVolume(_fxBusIndex, amout);

    private void UpdateAudioBusVolume(int busIndex, float amout)
    {
        if (Mathf.IsZeroApprox(amout))
        {
            AudioServer.SetBusMute(busIndex, true);
        }
        else
        {
            var calcedLogValue = Mathf.Log(amout/50) * 20;
            AudioServer.SetBusMute(busIndex, false);
            AudioServer.SetBusVolumeDb(busIndex, calcedLogValue);
        }
    }




}
