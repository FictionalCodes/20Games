using Godot;
using Godot.Collections;

//[Tool]
public partial class VisibilityModifier : CheckBox
{
    public enum HideMode{
        Visibility,
        Modulation,
    }

    [Export] HideMode modifierMode;
    [Export] CanvasItem[] itemsToHide;

    public override void _Ready()
    {
        base._Ready();
        this.Toggled += OnToggled;
    }

    public override void _ExitTree()
    {
        base._ExitTree();
        this.Toggled -= OnToggled;

    }

    public void OnToggled(bool toggledOn)
    {
        //if(!Engine.IsEditorHint())
        //{
            GD.Print($"Toggling Button");

            foreach (var item in itemsToHide)
            {
                switch (modifierMode)
                {
                    case HideMode.Visibility:
                        item.Visible = toggledOn;
                        break;
                    case HideMode.Modulation:
                        var modulate = item.Modulate;
                        modulate.A = toggledOn ? 1 : 0;
                        item.Modulate = modulate;

                        break;
                }

            }
        //}

        //EmitSignal(SignalName.Toggled, toggledOn);

        //base._Toggled(toggledOn);

    }


    public override bool _Set(StringName property, Variant value)
    {
        GD.Print($"Property Name = {property}");

        if (property == PropertyName.ButtonPressed)
        {
            var visibilityValue = value.AsBool();
            GD.Print($"button_pressed = {visibilityValue}");

            foreach (var item in itemsToHide)
            {
                switch (modifierMode)
                {
                    case HideMode.Visibility:
                        item.Set(PropertyName.Visible, value);
                        break;
                    case HideMode.Modulation:
                        var modulate = item.Modulate;
                        modulate.A = visibilityValue ? 1 : 0;

                        item.Set(PropertyName.Modulate, modulate);

                        break;
                }

                item.NotifyPropertyListChanged();
            }

            this.ButtonPressed = visibilityValue;
            return true;

        }

        return base._Set(property, value);
    }
}
