extends Control


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("pause"):
        visible = !visible
        get_tree().paused = !get_tree().paused

func _on_resume_button_pressed() -> void:
    hide()
    get_tree().paused = false

func _on_exit_game_button_pressed() -> void:
    get_tree().quit()
