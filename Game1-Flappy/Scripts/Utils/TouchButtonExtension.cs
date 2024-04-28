using Game1flappy.Scripts.Extensions;
using Godot;
using System;


public partial class TouchButtonExtension : TouchScreenButton
{
    [Export] bool BlockInput{get;set;} = true;

    [Signal]
    public delegate void OnButtonPressedEventHandler();

    
    public void TouchButtonPress()
    {
        if(!BlockInput)GetViewport().SetInputAsHandled();
        EmitSignal(SignalName.OnButtonPressed);
    }
}