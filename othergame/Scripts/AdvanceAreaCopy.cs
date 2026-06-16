using Godot;
using System;

public partial class AdvanceAreaCopy : StaticBody3D
{
    [Export(PropertyHint.File, "*.tscn")]
    public string nextScene { get; set; } = "";
    [Export] private string displayName;
    private AudioStreamPlayer3D audi;
    [Export] private PackedScene audioScene = (PackedScene)ResourceLoader.Load("res://Audio/advance_audio.tscn");
    [Export] private bool noSound;

    public override void _Ready()
    {
        base._Ready();
        SetCollisionLayerValue(2, true);
		SetCollisionLayerValue(1, false);
		SetCollisionMaskValue(1, false);
    }

    public override void _Process(double delta)
    {
        base._Process(delta);
    }
    public void Interact()
    {
        AnimationPlayer anim = (AnimationPlayer) GetTree().GetFirstNodeInGroup("trAnim");
        anim.Play("fadeIn");
        anim.Set("nextScene", nextScene);
        anim.Set("teleport", false);

        if (!noSound)
        {
            if (GetChild(1) == null)
            {
                Node auInstance = audioScene.Instantiate();
                AddChild(auInstance);

                audi = (AudioStreamPlayer3D) auInstance;
            }
            
            audi.Play();
        }
    }

    public string GetDisplayName()
    {
        return displayName;
    }
}
