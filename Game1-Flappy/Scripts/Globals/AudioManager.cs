using Godot;
using System;

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
        settingsBindings.MusicVolumeChange += UpdateMusicVolume;
        settingsBindings.FxVolumeChange += UpdateFXVolume;
    }

    public override void _ExitTree()
    {
        base._ExitTree();

        var settingsBindings = GetNode<SettingsManager>("/root/SettingsManager");
        settingsBindings.MusicVolumeChange -= UpdateMusicVolume;
        settingsBindings.FxVolumeChange -= UpdateFXVolume;
    }


    public void UpdateMusicVolume(float amout) =>
        AudioServer.SetBusVolumeDb(_musicBusIndex, -50.0f + amout);
    public void UpdateFXVolume(float amout) =>
        AudioServer.SetBusVolumeDb(_fxBusIndex, -50.0f + amout);

}
