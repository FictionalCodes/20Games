

using Godot;

namespace Game1flappy.Scripts.Globals.ConfigurationObjects
{
    public partial class SoundSettings : SettingsBase
    {
        private float _musicVolume;
        private float _fXVolume;

        public SoundSettings() :base("SoundSettings") {}

        public float MusicVolume { get => _musicVolume; set
            {
                _musicVolume = value;
                UpdatedValueAction();
            }
        }
        public float FXVolume { get => _fXVolume; set
            {
                _fXVolume = value;
                UpdatedValueAction();
            }
        }

        public override void LoadFromConfig(ConfigFile config)
        {
            _musicVolume = (float)config.GetValue(ConfigSectionName, "MusicVolume", 25).AsDouble();
            _fXVolume = (float)config.GetValue(ConfigSectionName, "FXVolume", 25).AsDouble();
        }

        public override void SaveToConfig(ConfigFile config)
        {
            config.SetValue(ConfigSectionName, "MusicVolume", MusicVolume);
            config.SetValue(ConfigSectionName, "FXVolume", FXVolume);
        }
    }
}