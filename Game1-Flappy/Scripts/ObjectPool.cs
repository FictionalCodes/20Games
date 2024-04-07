using System.Collections.Generic;
using System.Linq;
using Godot;

public partial class NodePool<[MustBeVariant] T> : RefCounted where T : Node
{

    private List<T> _itemPool;

    [ExportGroup("Object Pool")]
    [Export] public PackedScene ItemToPool { get; set; }
    [Export] public int StarterCount { get; set; } = 10;

    [Export] public bool AllowPoolExpansion { get; set; } = true;

    public NodePool(PackedScene item) : base()
    {
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

            _itemPool.Add(ItemToPool.Instantiate<T>());
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

    public T GetPooledItem()
    {
        var result = _itemPool.FirstOrDefault(node => !node.IsInsideTree());

        if (result != null || !AllowPoolExpansion) return result;

        var currentPoolCount = _itemPool.Count;
        InitialisePool(currentPoolCount + (currentPoolCount / 2));
        return GetPooledItem();
    }
}
