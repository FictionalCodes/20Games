
using Godot;

namespace Game1flappy.Scripts.Extensions
{
    public static class CanvasItemExtensions
    {
        public static Vector2 GetGlobalPosition(this CanvasItem canvasItem)
        {
            if(canvasItem is Node2D node2d)
            {
                return node2d.GlobalPosition;
            }
            if (canvasItem is Control con)
            {
                return con.GlobalPosition;
            }

            return Vector2.Zero;
        }
    }
}