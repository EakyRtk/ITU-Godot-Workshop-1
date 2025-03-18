class_name Bullet
extends Area2D

@export var damage : int = 1
@export var drift_speed : float = 200.0

func _ready() -> void:
    drift_speed += randf_range(-20, 20)

func _process(delta: float) -> void:
    position.x += drift_speed * delta

func _screen_exited() -> void:
    queue_free()