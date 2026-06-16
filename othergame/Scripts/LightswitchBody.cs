using Godot;
using System;

public partial class LightswitchBody : StaticBody3D
{
    [Export] OmniLight3D light;
    [Export] string displayName = "Lightswitch";
    [Export] bool defaultState = false;
    [Export] AudioStreamPlayer3D audio;
    public override void _Ready()
    {
        base._Ready();

        if (defaultState)
        {
            light.Visible = true;
        }
        else
        {
            light.Visible = false;
        }
    }

    public string GetDisplayName()
    {
        return displayName;
    }

    public void Toggle()
    {
        if (light.Visible)
        {
            light.Visible = false;
        }
        else
        {
            light.Visible = true;
        }

        if (audio != null)
        {
            audio.Play();
        }
    }
}
