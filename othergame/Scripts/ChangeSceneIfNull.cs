using Godot;
using System;

[GlobalClass]
public partial class ChangeSceneIfNull : Node
{
    private enum states {NULL, X};
    [Export] private states advanceIf = states.NULL;
    [Export] private Node requiredNull;
    [Export] private int requiredX;

    private AnimationPlayer trAnim;
    private Node global;
    
    [Export(PropertyHint.File, "*.tscn")] public string nextScene { get; set; } = "";

    public override void _Ready()
    {
        base._Ready();
        trAnim = (AnimationPlayer) GetTree().GetFirstNodeInGroup("trAnim");
        global = GetTree().GetFirstNodeInGroup("Global");

        if (advanceIf == states.X)
        {
            global.Set("x", 0);
        }
    }

    public override void _Process(double delta)
    {
        base._Process(delta);

        if ((advanceIf == states.NULL && !IsInstanceValid(requiredNull)) || (advanceIf == states.X && (int) global.Get("x") == requiredX))
        {
            trAnim.Call("Advance", nextScene);
            QueueFree();
        } 
    }
}
