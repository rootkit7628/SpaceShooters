extends Node2D

@export var SPEED = 400.0
@onready var DIRECTION := Vector2.RIGHT.rotated(rotation)

func _physics_process(delta: float) -> void:
	var velocity = DIRECTION * SPEED * delta
	global_position += velocity
