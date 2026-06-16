extends Label


@export var hotels : Array[Hotel]
var index : int = 0
@onready var rent : Button = $"../Rent"

func _ready() -> void:
	var k : String
	var currentHotel : Hotel = hotels[index]
	if currentHotel.kitchen:
		k = "yes"
	else:
		k = "no"
	text = "Price: $" + str(currentHotel.price) + "\n\nNumber of bedrooms: " + str(currentHotel.numOfRooms) + "\n\nHas kitchen: " + k   
	if currentHotel.available:
		rent.visible = true
	else:
		rent.visible = false
	

func _on_next_button_up() -> void:
	if index < 3:
		index += 1
		_ready()
		$"../../AudioStreamPlayer2".play()


func _on_prev_button_up() -> void:
	if index > 0:
		index -= 1
		_ready()
		$"../../AudioStreamPlayer2".play()


func _on_rent_button_up() -> void:
	var anim : AnimationPlayer = get_tree().get_first_node_in_group("trAnim")
	anim.play("fadeIn")
	anim.nextScene = "res://Scenes/0_point_5.tscn"
	$"../../AudioStreamPlayer".play()
