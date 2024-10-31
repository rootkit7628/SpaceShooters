extends CharacterBody2D
class_name Player

@export_range(0.0, 1.0) var ACCEL_FACTOR: float = 0.1
@export_range(0.0, 1.0) var ROTATION_ACCEL_FACTOR: float = 0.1
@export var PROJECTILE_SCENE : PackedScene

var SPEED : float = 0.0
var MAX_SPEED : float = 200.0
var DIRECTION : Vector2 = Vector2.ZERO 
var LAST_DIRECTION : Vector2 = Vector2.ZERO

signal projectile_fired(PROJECTILE)


func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	player_move()
	player_rotate()

func _input(event: InputEvent) -> void:
	DIRECTION = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if DIRECTION != Vector2.ZERO:
		LAST_DIRECTION = DIRECTION
	
	if event.is_action_pressed("fire"):
		fire()

func player_move() -> void:
	# Move the player
	if DIRECTION == Vector2.ZERO:
		SPEED = lerp(SPEED, 0.0, ACCEL_FACTOR)
	else:
		SPEED = lerp(SPEED, MAX_SPEED, ACCEL_FACTOR)
	velocity = LAST_DIRECTION * SPEED
	move_and_slide()

func player_rotate() -> void:
	# Rotate the player
	var mouse_pos = get_global_mouse_position()
	var angle = global_position.angle_to_point(mouse_pos)
	rotation = lerp_angle(rotation, angle, ROTATION_ACCEL_FACTOR)

func destroy() -> void:
	queue_free()

func fire() -> void:
	var projectile = PROJECTILE_SCENE.instantiate()
	projectile.transform = global_transform
	projectile_fired.emit(projectile)
