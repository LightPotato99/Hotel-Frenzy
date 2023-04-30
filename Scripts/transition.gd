extends CanvasLayer

func change_scene_to_file(target: String) -> void:
	$AnimationPlayer.play('transition')
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	if MainMusic.playing == false:
		MainMusic.play()
	$AnimationPlayer.play_backwards("transition")
