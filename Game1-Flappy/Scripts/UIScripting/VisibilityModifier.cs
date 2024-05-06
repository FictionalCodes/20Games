using Godot;
using Godot.Collections;

[Tool]
public partial class VisibilityModifier : CheckBox
{
    [Export] CanvasItem[] itemsToHide;

    public override void _Ready()
    {
        base._Ready();

    }

    public override void _Toggled(bool toggledOn)
    {
        if(!Engine.IsEditorHint())
        {
            base._Toggled(toggledOn);

            foreach(var item in itemsToHide)
            {
                item.Visible = toggledOn;
            }
        }
    }

    public override bool _Set(StringName property, Variant value)
    { 
        if (property == PropertyName.ButtonPressed)
        {
            var visibilityValue = value.AsBool();
            GD.Print($"button_pressed = {visibilityValue}");

            foreach (var item in itemsToHide)
            {
                item.Set(PropertyName.Visible, visibilityValue);
                item.NotifyPropertyListChanged();
            }

            this.ButtonPressed = visibilityValue;
            return true;

        }

        return base._Set(property, value);
    }


}
