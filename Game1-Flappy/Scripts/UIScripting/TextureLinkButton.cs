using Godot;
using System;

public partial class TextureLinkButton : TextureButton
{
    [Export] string url;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
        ButtonUp += () => OS.ShellOpen(url);
	}

}
