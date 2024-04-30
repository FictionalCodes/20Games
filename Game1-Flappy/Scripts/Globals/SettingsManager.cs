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
    private ConfigFile _config;
    private int _highScore;

    public float MusicVolume { get => _musicVolumeNumber; set {_musicVolumeNumber = value; EmitSignal("MusicVolumeChange", _musicVolumeNumber);}}
    public float FxVolume { get => _fxVolumeNumber; set {_fxVolumeNumber = value; EmitSignal("FxVolumeChange", _fxVolumeNumber); }}
    public bool ParticlesOn { get => _particlesOn; set { _particlesOn = value; EmitSignal("ParticlesOnChange", _particlesOn); } }
    public bool LightingOn { get => _lightingOn; set { _lightingOn = value; EmitSignal("LightingOnChange", _lightingOn); } }

    public int HighScore { get => _highScore; set => _highScore = value; }


    [Signal] public delegate void MusicVolumeChangeEventHandler(float volume);
    [Signal] public delegate void FxVolumeChangeEventHandler(float volume);
    [Signal] public delegate void ParticlesOnChangeEventHandler(bool enabled);
    [Signal] public delegate void LightingOnChangeEventHandler(bool enabled);


    private const string ConfigurationSection = "Settings";
    private const string ScoresSection = "Scores";
    private const string ConfigFilePath = "user://config.cfg";


    public override void _Ready()
    {
        base._Ready();
        _config = new ConfigFile();
        // Load data from a file.
        GD.Print("loading config file");
        Error err = _config.Load(ConfigFilePath);


        if (err == Error.DoesNotExist || err == Error.FileNotFound)
        {
            GD.Print("saving default config file");

            SaveConfiguration();
        }
        else
        {
            GD.Print("reading config file");

            LoadConfiguration();
        }
    }

    private void LoadConfiguration()
    {
        _musicVolumeNumber = (float)_config.GetValue(ConfigurationSection, "MusicVolume");
        _fxVolumeNumber = (float)_config.GetValue(ConfigurationSection, "FXVolume");
        _particlesOn = (bool)_config.GetValue(ConfigurationSection, "ParticlesOn");
        _lightingOn = (bool)_config.GetValue(ConfigurationSection, "LightingOn");
        _highScore = (int)_config.GetValue(ScoresSection, "HighScore");
        GD.Print("config loaded");

        GD.Print($"MusicVolume - {_musicVolumeNumber}");
        GD.Print($"FXVolume - {_fxVolumeNumber}");
        GD.Print($"ParticlesOn - {_particlesOn}");
        GD.Print($"MusicVolume - {_lightingOn}");

    }


    public void SaveConfiguration()
    {
        _config.SetValue(ConfigurationSection, "MusicVolume", _musicVolumeNumber);
        _config.SetValue(ConfigurationSection, "FXVolume", _fxVolumeNumber);
        _config.SetValue(ConfigurationSection, "ParticlesOn", _particlesOn);
        _config.SetValue(ConfigurationSection, "LightingOn", _lightingOn);
        _config.SetValue(ScoresSection, "HighScore", _highScore);
        _config.Save(ConfigFilePath);
        GD.Print("config saved");
    }
}
