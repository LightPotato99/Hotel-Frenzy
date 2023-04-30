extends AudioStreamPlayer2D

func faster():
	pitch_scale += 0.05

func reset_pitch():
	pitch_scale = 1
