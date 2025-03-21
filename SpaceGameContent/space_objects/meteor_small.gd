extends Area2D

@onready var health_bar : TextureProgressBar = $HealthBrogressBar

@export var drift_speed : float = 100.0
@export var damage : int = 1

@onready var hit_sfx : AudioStreamPlayer2D = $Hit

@export var health : int = 2:
	set(value):
		#can 0 ise yok edeceğiz
		if value <= 0:

			#-- görünürlüğü kapadık, hareket etmesini durdurmak için processi kapadık ve collision disabledi true yaptık ki artık hesaplamaya katılmasın
			#ancak sfx in bitmesini bekliyoruz. Böylece SFX yarıda kesilmeyecek.
			
			#direkt visible = false veya hide() dersek _screen_exited çalışacak ve sfx bitmeden obje yok olacak
			$Line2D.hide()
			$Sprite2D.hide()
			$HealthBrogressBar.hide()

			set_process(false)
			$CollisionShape2D.set_deferred("disabled", true)
			#----
			await hit_sfx.finished
			queue_free()
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
		area.queue_free()
		hit_sfx.play()

		health -= area.damage
