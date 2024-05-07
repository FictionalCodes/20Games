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
    }

    private void UpdateVolumes(SoundSettings settings)
    {
        UpdateMusicVolume(settings.MusicVolume);
        UpdateFXVolume(settings.FXVolume);
    }

    //-50-0 as reference range 
    public void UpdateMusicVolume(float amout)
    {
        UpdateAudioBusVolume(_musicBusIndex, amout);
    }

    private void UpdateAudioBusVolume(int busIndex, float amout)
    {
        if (Mathf.IsZeroApprox(amout))
        {
            AudioServer.SetBusMute(busIndex, true);
        }
        else
        {
            AudioServer.SetBusMute(busIndex, false);
            AudioServer.SetBusVolumeDb(busIndex, Mathf.Log(-50.0f + amout) * 20);
        }
    }


    public void UpdateFXVolume(float amout)
    {
        UpdateAudioBusVolume(_fxBusIndex, amout);
    }


}
