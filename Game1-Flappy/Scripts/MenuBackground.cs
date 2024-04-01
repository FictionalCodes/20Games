using Godot;
using System;

public partial class MenuBackground : ParallaxBackground
{
	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
        this.ScrollOffset += Vector2.Left;
	}
}
