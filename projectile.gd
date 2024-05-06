class_name Projectile 

extends Area2D

var direction : Vector2 = Vector2.LEFT # default direction
@export var speed : float = 100 #put your rocket speed

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	translate(direction*speed*delta)
	if position.x < 0 or position.y < 0 or position.x > get_window().size.x or position.y > get_window().size.y:
		queue_free()


func _on_body_entered(body):
	if body is Player:
		body.die()
