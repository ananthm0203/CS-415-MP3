class_name Miniboss

extends Area2D

@export var max_shots_per_period = 3
@export var projectile = preload("res://projectile.tscn")
@export var miniboss = false
@export var deltas_to_reach = 100
@export var speed = 20
@export var health = 3
@export var on_kill_win = true
@export var win_screen : String

var shots_fired = 0
var goto_player = false
var dest_pos : Vector2i
var dir : Vector2
var offset : Vector2
var remaining_deltas : int
var taken_damage = false

@onready var player = get_node("/root/" + get_tree().current_scene.name + "/Player")

# Called when the node enters the scene tree for the first time.
func _ready():
	if not miniboss:
		$Health.hide()
	else:
		$Health.max_value = health
		$Health.value = health
	if player:
		$BurstTimer.start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if miniboss and goto_player:
		position += offset
		remaining_deltas -= 1
		if remaining_deltas == 0:
			goto_player = false
			taken_damage = false
			set_collision_layer_value(2, false)
			$BurstTimer.start()
	elif player:
		var dir = (player.global_position - global_position).normalized()
		translate(dir * speed * delta)
	else:
		player = get_node("/root/" + get_tree().current_scene.name + "/Player")
		if player:
			$BurstTimer.start()

func take_damage():
	if not taken_damage:
		health -= 1
		$Health.value -= 1
		#print_debug("Health currently ", $Health.value)
		taken_damage = true
		if health <= 0:
			queue_free()
			get_tree().call_deferred("change_scene_to_file", win_screen)

func _on_burst_timer_timeout():
	$ShotTimer.start()
	pass # Replace with function body.

func stop_timers():
	$ShotTimer.stop()
	$BurstTimer.stop()

func _on_shot_timer_timeout():
	# spawn shot
	var proj_inst = projectile.instantiate()
	get_parent().add_child(proj_inst)
	proj_inst.global_position = global_position
	dir = (player.global_position - global_position).normalized()
	proj_inst.global_rotation = dir.angle() + PI / 2.0
	proj_inst.direction = dir
	if miniboss:
		proj_inst.set_scale(Vector2(0.75, 0.75))
		proj_inst.speed = 160
	shots_fired += 1
	# Reset shot timers
	if shots_fired >= max_shots_per_period:
		shots_fired = 0
		if miniboss:
			offset = (player.global_position - global_position) / deltas_to_reach
			remaining_deltas = deltas_to_reach
			$RushTimer.start()
		else:
			$BurstTimer.start()
	else:
		$ShotTimer.start()


func _on_rush_timer_timeout():
	goto_player = true
	set_collision_layer_value(2, true)


func _on_body_entered(body):
	if body is Player:
		body.die()
