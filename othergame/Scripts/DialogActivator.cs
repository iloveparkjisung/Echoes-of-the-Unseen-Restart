using Godot;
using System;

[GlobalClass]
public partial class DialogActivator : StaticBody3D
{
	[Export] public string dialogicTimeline;
	[Export] public bool selfDestruct;
	[Export] private string displayName;

	public override void _Ready()
	{
		base._Ready();
		SetCollisionLayerValue(2, true);
		SetCollisionLayerValue(1, false);
		SetCollisionMaskValue(1, false);

		AddToGroup("dialog");
	}
	public string GetDisplayName()
	{
		return displayName;
	}
}
