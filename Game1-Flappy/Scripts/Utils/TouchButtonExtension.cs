using Godot;
using System;


public partial class TouchButtonExtension : TouchScreenButton
{

    [Signal]
    public delegate void OnButtonPressedEventHandler();

    public void TouchButtonPress()
    {
        GetViewport().SetInputAsHandled();
        EmitSignal(SignalName.OnButtonPressed);
    }
}