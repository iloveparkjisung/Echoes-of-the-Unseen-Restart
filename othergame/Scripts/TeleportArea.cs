using Godot;
using System;

[GlobalClass]
public partial class TeleportArea : StaticBody3D
{
    private AudioStreamPlayer3D audio;
    [Export] string displayName = "Door";
    [Export] Node3D targetPos;
    [Export] private PackedScene audioScene;
    public override void _Ready()
	{
		base._Ready();
		SetCollisionLayerValue(2, true);
		SetCollisionLayerValue(1, false);
        SetCollisionMaskValue(1, false);

        AddToGroup("tp");
	}

    public void Teleport()
    {
        AnimationPlayer anim = (AnimationPlayer) GetTree().GetFirstNodeInGroup("trAnim");
        anim.Play("fadeIn");

        anim.Set("teleport", true);
        anim.Set("nextPos", targetPos);

        if (displayName == "Door")
        {
            
            if (GetChild(2) == null)
            {
                Node auInstance = audioScene.Instantiate();
                AddChild(auInstance);

                audio = (AudioStreamPlayer3D) auInstance;
            }
            
            audio.Play();
        }
        
    }

    public string GetDisplayName()
    {
        return displayName;
    }
}
