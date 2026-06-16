using Godot;
using System;

[GlobalClass]
public partial class FreeStuff : Node
{
    private enum states {FREE_IF_X, FREE_IF_NULL, FREE_AFTER_TIME};
    [Export]private states state = states.FREE_IF_NULL;
    [Export] private Node requiredNull;
    [Export] private int requiredX;
    [Export] private double requiredTime;
    private Node global;
    [Export] private Node[] trash;

    public override void _Ready()
    {
        base._Ready();
        global = GetTree().GetFirstNodeInGroup("Global");
    }

    public override void _Process(double delta)
    {
        base._Process(delta);
        if (state == states.FREE_AFTER_TIME)
        {
            requiredTime -= delta;
            if (requiredTime <= 0)
            {
                QueueFreeStuff();
            }
        }
        else if ((state == states.FREE_IF_NULL && !IsInstanceValid(requiredNull)) || (state == states.FREE_IF_X && (int)global.Get("x") == requiredX))
        {
            QueueFreeStuff();
            global.Set("x", 0);
        }

    }

    private void QueueFreeStuff()
    {
        for (int i = 0; i < trash.Length; i++)
        {
            trash[i].QueueFree();
        }
        QueueFree();
    }
}
