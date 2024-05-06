using System;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using Godot;


public partial class SettingsManager : Node
{

    private ConfigFile _config;
    private int _highScore;



    public int HighScore { get => _highScore; set => _highScore = value; }


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
            SaveConfiguration();
        }
        else
        {
            LoadConfiguration();
        }
    }

    private void LoadConfiguration()
    {
        _highScore = (int)_config.GetValue(ScoresSection, "HighScore");

    }


    public void SaveConfiguration()
    {
        _config.SetValue(ScoresSection, "HighScore", _highScore);
        _config.Save(ConfigFilePath);
    }

    //public static SettingsManager Instance =>uy 
}
