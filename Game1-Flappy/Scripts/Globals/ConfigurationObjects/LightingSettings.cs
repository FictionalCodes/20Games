using System.Collections.Generic;
using Godot;

namespace Game1flappy.Scripts.Globals.ConfigurationObjects
{

    public partial class LightingSettings : SettingsBase
    {

        public bool DynamicLightingEnabled { get => dynamicLightingEnabled; set
            {
                dynamicLightingEnabled = value;
                UpdatedValueAction();
            }
        }
        public ShadowQuality ShadowQualityValue { get => _shadowQualityValue; set
            {
                _shadowQualityValue = value;
                UpdatedValueAction();
            }
        }
        public enum ShadowQuality:ushort
        {
            Off = 0,
            Simple,
            High,
            Ultra
        }

        private Dictionary<ShadowQuality, Light2D.ShadowFilterEnum> ShadowValueMapping = new Dictionary<ShadowQuality, Godot.Light2D.ShadowFilterEnum>()
        {
            {ShadowQuality.Simple, Light2D.ShadowFilterEnum.None},
            {ShadowQuality.High, Light2D.ShadowFilterEnum.Pcf5},
            {ShadowQuality.Ultra, Light2D.ShadowFilterEnum.Pcf13},
        };
        private bool dynamicLightingEnabled = true;
        private ShadowQuality _shadowQualityValue = ShadowQuality.High;

        public LightingSettings() : base("LightingSettings")
        {
        }

        public Light2D.ShadowFilterEnum? GetMappedValue(ShadowQuality quality) =>
            ShadowValueMapping.TryGetValue(quality, out var result) ? result : null;

        public override void LoadFromConfig(ConfigFile config)
        {
            DynamicLightingEnabled = config.GetValue(ConfigSectionName, "DynamicOn", true).AsBool();
            ShadowQualityValue = (ShadowQuality)config.GetValue(ConfigSectionName, "ShadowQuality", 2).AsUInt16();
        }

        public override void SaveToConfig(ConfigFile config)
        {
            config.SetValue(ConfigSectionName, "ShadowQuality", (ushort)ShadowQualityValue);
            config.SetValue(ConfigSectionName, "DynamicOn", DynamicLightingEnabled);
        }
    }
}