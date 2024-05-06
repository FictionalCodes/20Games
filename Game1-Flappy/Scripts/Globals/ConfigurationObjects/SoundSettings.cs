

using Godot;

namespace Game1flappy.Scripts.Globals.ConfigurationObjects
{
    public partial class SoundSettings : SettingsBase
    {
        public SoundSettings() :base("SoundSettings") {}
        
        public float MusicVolume {get;set;}
        public float FXVolume {get;set;}

        public override void LoadFromConfig(ConfigFile config)
        {
            MusicVolume = (float)config.GetValue(ConfigSectionName, "MusicVolume", 25).AsDouble();
        }

        public override void SaveToConfig(ConfigFile config)
        {
            throw new System.NotImplementedException();
        }
    }
}