using System;
using Godot;

namespace Game1flappy.Scripts.Globals.ConfigurationObjects
{
    public abstract partial class SettingsBase : RefCounted
    {
        public SettingsBase(string configSectionName)
        {
            ConfigSectionName = configSectionName;
        }
        public string ConfigSectionName {get;set;}
        public Action UpdatedValueAction {get; set;}
        public void NotifiyValuesUpdated() => UpdatedValueAction?.Invoke();

        public abstract void LoadFromConfig(ConfigFile config);
        public abstract void SaveToConfig(ConfigFile config);
    }
}