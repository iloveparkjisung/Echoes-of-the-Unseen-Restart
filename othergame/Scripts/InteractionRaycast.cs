using Godot;
using System;

public partial class InteractionRaycast : RayCast3D
{
    [Export]private CharacterBody3D player;
    private Label nLabel;
    private Node Dialogic;
    private Node Global;
    public Node collider;
    public override void _Ready()
    {
        base._Ready();
        nLabel = (Label)GetTree().GetFirstNodeInGroup("nameLabel");
        Dialogic = GetTree().GetFirstNodeInGroup("dialogic");
        Global = GetTree().GetFirstNodeInGroup("Global"); 

        SetCollisionMaskValue(1, false);
        SetCollisionMaskValue(2, true);
        ForceRaycastUpdate();
    }

    public override void _Process(double delta)
    {
        base._Process(delta);
        if (IsColliding() && !(bool)Dialogic.Get("dialogActive"))
        {
            Global.Set("canInteract", true);
            collider =(Node) GetCollider();


            if (collider != null && collider.HasMethod("GetDisplayName"))
            {
                string displayName = (string)collider.Call("GetDisplayName");
                nLabel.Set("text", displayName); 
            }

            if (Input.IsActionJustReleased("Interact") && !(bool)Global.Get("delay"))
            {
                Global.Set("delay", true);

                if (collider.IsInGroup("dialog"))
                {
                    Dialogic.Call("start", collider.Get("dialogicTimeline"));
                    player.Set("canMove", false);

                    if ((bool)collider.Get("selfDestruct"))
                    {
                        collider.QueueFree();
                    }
                }

                else if (collider.IsInGroup("animActivator"))
                {
                    collider.Call("playAnim");
                }

                else if (collider.IsInGroup("switch"))
                {
                    collider.Call("Toggle");
                }

                else if (collider.IsInGroup("tp"))
                {
                    collider.Call("Teleport");
                }

                else if (collider.IsInGroup("pickup"))
                {
                    collider.Call("Destroy");
                }
                else if (collider.HasMethod("Interact"))
                {
                    collider.Call("Interact");
                }

                if (!collider.IsInGroup("dialog"))
                {
                    Global.Set("delay", false);
                }

                
            }
        }
        else
        {
            Global.Set("canInteract", false);
            nLabel.Set("text", "");
        }
    }
}
