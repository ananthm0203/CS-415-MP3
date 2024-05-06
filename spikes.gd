extends Area2D

@export var show_sprite = true

# Called when the node enters the scene tree for the first time.
func _ready():
	if not show_sprite:
		$SpriteSpikes0.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if body is Player:
		if not show_sprite:
			$SpriteSpikes0.show()
		body.die()


func _on_area_entered(area):
	if area is Miniboss:
		area.take_damage()
		queue_free()
