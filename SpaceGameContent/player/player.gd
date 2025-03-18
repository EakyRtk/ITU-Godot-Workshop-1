class_name Player
extends Node2D

const BULLET : PackedScene = preload("uid://dci6epiwlu4u6")

@onready var player_sprite : Sprite2D = $PlayerSprite
@onready var bullet_spawn_mark : Marker2D = $BulletSpawnPos
@onready var shoot_timer : Timer = $Timer

@export var speed : float = 500
var health : int = 5:
    set(value):
        if value <= 0: pass #kaybetme
        health = value

@export var shoot_cooldown : float = 1.0

#-- hep çalışır --
func _process(delta: float) -> void:
    var direction : float = Input.get_axis("up", "down")
    var velocity : float = direction * speed * delta

    #-- HAREKET KISITLAMA
    #ikinci değerde eğer yön yukarıysa diye de kontrol ettik çünkü aşağı gidecek olsak bile position.y - velocity 0'dan düşük olacak
    #ve hareketimizi kilitleyecek
    #if position.y + velocity > 1080 or (position.y - velocity < 0 and direction == -1): velocity = 0
    #--

    #-- KONUM IŞINLAMA
    #NOTE: Işınlama fizik objeleri (Rigidbody gibi) önerilmez, onun için _physics_process kullanmak gerekir. Detaylara dökümanlardan ulaşabilirsiniz.
    if position.y + velocity > 1080: position.y = 10; velocity = 0
    if position.y - velocity < 0 and direction == -1: position.y = 1090; velocity = 0
    #--

    position.y += velocity
    if shoot_timer.is_stopped() and Input.is_action_pressed("shoot"):
        _shoot()

#-- sadece bir tuşa bastığımızda çalışır --
#func _unhandled_input(event: InputEvent) -> void:
#    if event.is_action_pressed("shoot"):
#        _shoot()
#---

func _shoot() -> void:
    var _n_bullet : Bullet = BULLET.instantiate()
    #top level yaparak parent nodeden konumunu ve çizimini ayrı yapıyoruz. Eğer yapmazsak 
    #mermiler uzay aracıyla birlikte yukarı aşağı inecektir
    #ancak tamamen ayrı gibi davrandığı için başlangıç konumu da (0, 0) olacaktır. Ona dikkat etmemiz gerek.
    _n_bullet.top_level = true
    _n_bullet.global_position = bullet_spawn_mark.global_position
    bullet_spawn_mark.add_child(_n_bullet)
    shoot_timer.start(shoot_cooldown + randf_range(-0.02, 0.02))


func _on_hit_box_area_entered(area:Area2D) -> void:
    health -= area.damage
    print(health)