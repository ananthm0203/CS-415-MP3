extends Area2D

@export var new_scene : String 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		get_tree().call_deferred("change_scene_to_file", new_scene)
