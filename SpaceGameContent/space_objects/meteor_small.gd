extends Area2D

@onready var health_bar : TextureProgressBar = $HealthBrogressBar

@export var drift_speed : float = 100.0
@export var damage : int = 1

@export var health : int = 2:
    set(value):
        if value <= 0: queue_free()
        health = value
        health_bar.value = health

func _ready() -> void:
    health_bar.max_value = health
    health_bar.value = health

func _process(delta: float) -> void:
    position.x -= drift_speed * delta

func _screen_exited() -> void:
    queue_free()

func _on_area_entered(area:Area2D) -> void:
    if area is Bullet:
        health -= area.damage
        area.queue_free()