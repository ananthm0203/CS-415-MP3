extends Node2D

@export var chance : float

# Called when the node enters the scene tree for the first time.
func _ready():
	if randf() <= chance:
		var enemy = preload("res://miniboss.tscn").instantiate()
		enemy.position = get_window().size / 2
		enemy.apply_scale(Vector2(0.5, 0.5))
		add_child(enemy)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
