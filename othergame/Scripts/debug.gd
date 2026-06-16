extends Label

@onready var ir : RayCast3D = get_tree().get_first_node_in_group("ir")
func _process(delta: float) -> void:
	ir = get_tree().get_first_node_in_group("ir")
	if ir:
		text = "IsColliding(): " + str(ir.is_colliding())
	
	
