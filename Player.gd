### Player.gd
class_name Player

extends CharacterBody2D

#player movement variables
@export var speed : float
@export var jump_height : float
@export var jump_time_to_peak : float
@export var jump_time_to_descent : float
@export var max_jumps = 1

@onready var jump_velocity = (-2.0 * jump_height) / jump_time_to_peak
@onready var jump_gravity = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
@onready var fall_gravity = (2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)

@onready var jumps = max_jumps
var has_jumped = false

func get_gravity():
	return jump_gravity if velocity.y < 0 else fall_gravity

 #movement and physics
func _physics_process(delta):
	if position.x < 0 or position.x > get_window().size.x or position.y > get_window().size.y:
		die()
	# vertical movement velocity (down)
	velocity.y += get_gravity() * delta
	# horizontal movement processing (left, right)
	horizontal_movement()
	# applies movement
	
	if is_on_floor() and has_jumped:
		jumps = max_jumps
		has_jumped = false
	
	move_and_slide()
	if not is_on_floor() and not has_jumped:
		jumps -= 1
		has_jumped = true		
	# applies animations
	player_animations()

func die():
	get_tree().paused = true
	await get_tree().create_timer(0.25).timeout 
	get_tree().paused = false
	get_tree().reload_current_scene.call_deferred()

func horizontal_movement():
	# if keys are pressed it will return 1 for ui_right, -1 for ui_left, and 0 for neither
	var horizontal_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	# horizontal velocity which moves player left or right based on input
	velocity.x = horizontal_input * speed

#animations
func player_animations():
	
	#on left (add is_action_just_released so you continue running after jumping)
	if Input.is_action_pressed("ui_left") and is_on_floor():
		$AnimatedSprite2D.flip_h = true
		$AnimatedSprite2D.play("run")

	#on right (add is_action_just_released so you continue running after jumping)
	if Input.is_action_pressed("ui_right") and is_on_floor():
		$AnimatedSprite2D.flip_h = false
		$AnimatedSprite2D.play("run")
	
	if !Input.is_anything_pressed() and is_on_floor():
		$AnimatedSprite2D.play("idle")

#singular input captures
func _input(event):

	#on jump
	if event.is_action_pressed("ui_jump") and jumps > 0:
		has_jumped = true
		velocity.y = jump_velocity
		jumps -= 1
		$AnimatedSprite2D.play("jump")
