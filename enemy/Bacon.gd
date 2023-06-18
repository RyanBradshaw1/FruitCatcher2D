extends RigidBody2D

signal bacon

func _on_Area2D_area_entered(area):
	emit_signal("bacon")
	hide()
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

