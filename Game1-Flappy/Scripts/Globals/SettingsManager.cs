using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using Godot;


public partial class SettingsManager : Node
{
    private float _musicVolumeNumber = 25;
    private float _fxVolumeNumber = 25;

    private bool _particlesOn = true;

    private bool _lightingOn = true;

    public float MusicVolume { get => _musicVolumeNumber; set {_musicVolumeNumber = value; EmitSignal("MusicVolumeChange", _musicVolumeNumber);}}
    public float FxVolume { get => _fxVolumeNumber; set {_fxVolumeNumber = value; EmitSignal("FxVolumeChange", _fxVolumeNumber); }}
    public bool ParticlesOn { get => _particlesOn; set { _particlesOn = value; EmitSignal("ParticlesOnChange", _particlesOn); } }
    public bool LightingOn { get => _lightingOn; set { _lightingOn = value; EmitSignal("LightingOnChange", _lightingOn); } }

    [Signal] public delegate void MusicVolumeChangeEventHandler(float volume);
    [Signal] public delegate void FxVolumeChangeEventHandler(float volume);
    [Signal] public delegate void ParticlesOnChangeEventHandler(bool enabled);
    [Signal] public delegate void LightingOnChangeEventHandler(bool enabled);


    private const string ConfigurationSection = "Settings";
    public override void _Ready()
    {
        base._Ready();
        var config = new ConfigFile();
        // Load data from a file.
        Error err = config.Load("user://config.cfg");
        if(err == Error.DoesNotExist || err == Error.FileNotFound)
        {
            SaveConfiguration();
        }
    }

    private void SaveConfiguration()
    {
        
    }
}
