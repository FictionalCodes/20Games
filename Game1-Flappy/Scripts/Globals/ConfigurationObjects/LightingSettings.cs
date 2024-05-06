using System.Collections.Generic;
using Godot;

namespace Game1flappy.Scripts.Globals.ConfigurationObjects
{

    public partial class LightingSettings : Godot.RefCounted
    {
        
        public bool DynamicLightingEnabled { get; set; }
        public ShadowQuality ShadowQualityValue { get; set; }
        public enum ShadowQuality 
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

        public Light2D.ShadowFilterEnum? GetMappedValue(ShadowQuality quality) =>
            ShadowValueMapping.TryGetValue(quality, out var result) ? result : null;
            
        
    }
}