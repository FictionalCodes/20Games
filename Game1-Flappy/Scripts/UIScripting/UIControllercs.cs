using Godot;
using System;

public partial class UIControllercs : Node
{
    [Export]
    public OverlayController _uiOverlay { get; set; }

    public Action OnStartLife{get;set;}

    public void StartNewLife()
    {

    }

    public void GoToMainMenu()
    {

    }

}
