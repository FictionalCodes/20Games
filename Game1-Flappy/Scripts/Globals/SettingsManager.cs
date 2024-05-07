using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using Game1flappy.Scripts.Globals.ConfigurationObjects;
using Godot;


public partial class SettingsManager : Node
{

    private ConfigFile _config;
    private int _highScore;

    public LightingSettings LightingSettings { get; } = new LightingSettings();
    public ParticleSettings ParticleSettings { get; } = new ParticleSettings();
    public SoundSettings SoundSettings { get; } = new SoundSettings();


    public int HighScore { get => _highScore; set => _highScore = value; }

    [Signal] public delegate void LightingOnChangeEventHandler(LightingSettings settings);
    [Signal] public delegate void ParticlesOnChangeEventHandler(ParticleSettings settings);
    [Signal] public delegate void SoundOnChangeEventHandler(SoundSettings settings);

    public void NotifyLightingChanged() => EmitSignal(SignalName.LightingOnChange);
    public void NotifyParticlesChanged() => EmitSignal(SignalName.ParticlesOnChange);
    public void NotifySoundChanged() => EmitSignal(SignalName.SoundOnChange);

    private const string ConfigurationSection = "Settings";
    private const string ScoresSection = "Scores";
    private const string ConfigFilePath = "user://config.cfg";


    public override void _Ready()
    {
        base._Ready();
        _config = new ConfigFile();
        LightingSettings.UpdatedValueAction = NotifyLightingChanged;
        ParticleSettings.UpdatedValueAction = NotifyParticlesChanged;
        SoundSettings.UpdatedValueAction = NotifySoundChanged;

        // Load data from a file.
        GD.Print("loading config file");
        Error err = _config.Load(ConfigFilePath);


        if (err == Error.DoesNotExist || err == Error.FileNotFound)
        {
            SaveConfiguration();
        }
        else
        {
            LoadConfiguration();
        }
    }

    private void LoadConfiguration()
    {
        _highScore = _config.GetValue(ScoresSection, "HighScore").AsInt32();

        LightingSettings.LoadFromConfig(_config);
        ParticleSettings.LoadFromConfig(_config);
        SoundSettings.LoadFromConfig(_config);

    }


    public void SaveConfiguration()
    {
        LightingSettings.SaveToConfig(_config);
        ParticleSettings.SaveToConfig(_config);
        SoundSettings.SaveToConfig(_config);

        _config.SetValue(ScoresSection, "HighScore", _highScore);
        _config.Save(ConfigFilePath);
    }

    //public static SettingsManager Instance =>uy 
}
