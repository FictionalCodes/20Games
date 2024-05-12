using System;
using System.Collections.Generic;
using Godot;

namespace Game1flappy.Scripts.Globals.ConfigurationObjects
{
    public partial class ParticleSettings : SettingsBase
    {
        public bool ParticlesEnabledGlobal
        {
            get => _particlesEnabledGlobal;
            set
            {
                _particlesEnabledGlobal = value;
                UpdatedValueAction();
            }
        }
        public bool TrailEnabled
        {
            get => _trailEnabled;
            set
            {
                _trailEnabled = value;
                UpdatedValueAction();
            }
        }
        public bool BounceEnabled
        {
            get => _bounceEnabled; 
            set
            {
                _bounceEnabled = value;
                UpdatedValueAction();
            }
        }

        public ParticleQuantity Quantity
        {
            get => _quantity; 
            set
            {
                _quantity = value;
                UpdatedValueAction();
            }
        }

        public enum ParticleQuantity : ushort
        {
            Low,
            High
        }

        public Dictionary<ParticleQuantity, int> ParticleQuantityMapping = new Dictionary<ParticleQuantity, int>()
        {
            {ParticleQuantity.Low, 15},
            {ParticleQuantity.High, 30}
        };
        private bool _bounceEnabled = true;
        private bool _trailEnabled = true;
        private bool _particlesEnabledGlobal = true;
        private ParticleQuantity _quantity = ParticleQuantity.High;

        public ParticleSettings() : base("Particles")
        {
        }

        public int GetParticleQuanityValue(ParticleQuantity quantity) => ParticleQuantityMapping.TryGetValue(quantity, out int result) ? result : 2;

        public override void LoadFromConfig(ConfigFile config)
        {
            ParticlesEnabledGlobal = config.GetValue(ConfigSectionName, "GlobalEnable", true).AsBool();
            TrailEnabled = config.GetValue(ConfigSectionName, "TrailEnable", true).AsBool();
            BounceEnabled = config.GetValue(ConfigSectionName, "BounceEnable", true).AsBool();
            Quantity = (ParticleQuantity)config.GetValue(ConfigSectionName, "ParticleQuantity", 2).AsUInt16();
        }

        public override void SaveToConfig(ConfigFile config)
        {
            config.SetValue(ConfigSectionName, "GlobalEnable", ParticlesEnabledGlobal);
            config.SetValue(ConfigSectionName, "TrailEnable", TrailEnabled);
            config.SetValue(ConfigSectionName, "BounceEnable", BounceEnabled);
            config.SetValue(ConfigSectionName, "ParticleQuantity", (ushort)Quantity);
        }
    }
}