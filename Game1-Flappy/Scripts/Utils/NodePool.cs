using System.Collections.Generic;
using System.Linq;
using Godot;

namespace Game1flappy.Scripts.Utils
{

    public interface IPooledNode<[MustBeVariant] T>: IPooledNode where T : Node {}

    public interface IPooledNode
    {
        void SpawnIn();
        void DespawnOut();

    }

    public partial class NodePool<[MustBeVariant] T> : RefCounted where T : Node, IPooledNode
    {

        private List<T> _itemPool;

        [ExportGroup("Object Pool")]
        [Export] public PackedScene ItemToPool { get; set; }
        [Export] public int StarterCount { get; set; } = 10;

        [Export] public bool AllowPoolExpansion { get; set; } = true;

        private readonly string groupName;
        public NodePool(PackedScene item, string groupName = "") : base()
        {
            this.groupName = groupName;
            GD.Print("Creating Pool Item");
            ItemToPool = item;
            _itemPool = new List<T>(StarterCount);
            InitialisePool(StarterCount);
        }

        public void InitialisePool(int toNumber, bool nukePool = false)
        {
            if (nukePool)
            {
                ClearPool();
            }

            while (_itemPool.Count < toNumber)
            {
                GD.Print($"Creating Pooled Item {ItemToPool.ResourceName}");
                var newItem = ItemToPool.Instantiate<T>();
                GD.Print($"Created Pooled Item {newItem.Name}");
                _itemPool.Add(newItem);
            }
        }

        public void ClearPool()
        {
            foreach (var item in _itemPool)
            {
                item.QueueFree();
            }
            _itemPool.Clear();
        }

        public T GetNextAvalibleItem()
        {
            var result = _itemPool.FirstOrDefault(node => !node.IsInsideTree());

            if (result != null || !AllowPoolExpansion) return result;

            var currentPoolCount = _itemPool.Count;
            InitialisePool(currentPoolCount + (currentPoolCount / 2));
            return GetNextAvalibleItem();
        }

        public void ForceAllObjectsDespawn()
        {
            foreach(var item in _itemPool)
            {
                if(item.IsInsideTree())
                {
                    item.DespawnOut();
                }
            }
        }
    }
}