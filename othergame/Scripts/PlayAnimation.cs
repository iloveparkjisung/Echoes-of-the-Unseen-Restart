using Godot;
using System;

[GlobalClass]
public partial class PlayAnimation : AnimationPlayer
{
	private enum States {PLAY_ON_READY, PLAY_ON_X, PLAY_ON_NULL};
	[Export] private States nodeState = States.PLAY_ON_READY;
	[Export] private int requiredX = 1;
	[Export] private Node requiredNull;
	[Export] private string animName;
	[Export] private float timer = 0.0f;
	[Export] private double playTimer = 0.0;
	[Export] private string timeline = "";

	private bool animStarted;
	private Node dialogic;
	private Node global;
	private bool timerStarted;
	private float startTimer;

	public override void _Ready()
	{
		base._Ready();
		if (nodeState == States.PLAY_ON_READY && playTimer == 0.0)
		{
			Play(animName);
		}
		global = GetTree().GetFirstNodeInGroup("Global");
		startTimer = timer;

		if (timeline != "")
		{
			dialogic = GetTree().GetFirstNodeInGroup("dialogic");
		}
	}

	public override void _PhysicsProcess(double delta)
	{
		base._PhysicsProcess(delta);

		if (nodeState == States.PLAY_ON_READY && playTimer != 0.0 && !animStarted)
		{
			playTimer -= delta;
			if (playTimer <= 0 && !IsPlaying())
			{
				Play(animName);
				animStarted = true;
			}
		}
		
		if (nodeState == States.PLAY_ON_X && (int)global.Get("x") == requiredX)
		{
			Play(animName);
			global.Set("x", 0);
			if (timer != 0.0f)
			{
				timerStarted = true;
			}
		}
		else if (nodeState == States.PLAY_ON_NULL && !IsInstanceValid(requiredNull) && !animStarted) 
		{
			animStarted = true;
			Play(animName);
		}

		if (timerStarted)
		{
			timer -= (float) delta;

			if (timer <= 0 || timer > startTimer)
			{
				QueueFree();
			}
		}

	}

	public void StartTimeline()
	{
		dialogic.Call("start", timeline);
	}

	public void SetGlobalX(int x)
	{
		global.Call("SetX", x);
	}
}
