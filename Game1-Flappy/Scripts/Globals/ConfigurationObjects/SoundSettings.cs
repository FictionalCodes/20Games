

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
            MusicVolume = (float)config.GetValue(ConfigSectionName, "MusicVolume", 25).AsDouble();
            MusicVolume = (float)config.GetValue(ConfigSectionName, "MusicVolume", 25).AsDouble();
        }

        public override void SaveToConfig(ConfigFile config)
        {
            throw new System.NotImplementedException();
        }
    }
}