extends Node2D


func _ready() -> void:
	$HSlider.value = Global.sensitivity
	$ShaderButton.button_pressed = Global.shaderOn
	$OverlayButton.button_pressed = Global.overlayOn

func _process(delta: float) -> void:
	if Input.is_action_just_released("Menu"):
		visible = !visible
		Global.menuActive = visible

func _on_h_slider_value_changed(value: float) -> void:
	Global.sensitivity = value

func _on_shader_button_toggled(toggled_on: bool) -> void:
	Global.shaderOn = toggled_on

func _on_overlay_button_toggled(toggled_on: bool) -> void:
	Global.overlayOn = toggled_on
