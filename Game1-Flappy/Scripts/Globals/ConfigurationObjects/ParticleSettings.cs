using System.Collections.Generic;
using Godot;

namespace Game1flappy.Scripts.Globals.ConfigurationObjects
{
    public partial class ParticleSettings : SettingsBase
    {
        public bool ParticlesEnabledGlobal {get;set;}
        public bool TrailEnabled {get;set;}
        public bool BounceEnabled {get;set;}

        public enum ParticleQuantity
        {
            Low = 1,
            High
        }

        public Dictionary<ParticleQuantity, int> ParticleQuantityMapping = new Dictionary<ParticleQuantity, int>()
        {
            {ParticleQuantity.Low, 15},
            {ParticleQuantity.High, 30}
        };

        public int GetParticleQuanityValue(ParticleQuantity quantity) => ParticleQuantityMapping.TryGetValue(quantity, out int result) ? result : 0;
        
    }
}