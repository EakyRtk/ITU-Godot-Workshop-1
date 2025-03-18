extends Control

#uid, dosyanın konumunu değiştirsek bile yüklemede sorun yaşamamızı engeller
#aynı şekilde uid kullanmak yerie "res://game_world.tscn" de diyebilirdik.
@onready var scene_packed : PackedScene = preload("uid://cyyq2mhf0h541")

func _on_play_button_pressed() -> void:
    get_tree().change_scene_to_packed(scene_packed)

func _on_exit_button_pressed() -> void:
    get_tree().quit()