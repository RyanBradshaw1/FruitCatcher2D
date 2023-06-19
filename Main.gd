extends Node

var score
var high_score
var timer
var watermelon_scene = preload("res://enemy/Watermelon.tscn")
var bacon_scene = preload("res://enemy/Bacon.tscn")
var hourglass_scene = preload("res://enemy/Hourglass.tscn")

func _ready():
	new_game()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
	if timer == 0:
		end_game()
	
	if $Labels/Retry.visible and Input.is_action_just_pressed("retry"):
		new_game()
	elif $Labels/Retry.visible and Input.is_action_just_pressed("quit"):
		queue_free()
		get_tree().change_scene("res://MainMenu.tscn")

func new_game():
	score = 0
	timer = 15
	$Labels/Retry.hide()
	$Labels/FinalScore.hide()
	$Labels/NewHighScore.hide()
	$Labels/GoLabel.show()
	$Labels/GameTimerLabel.set_text(str(timer))
	$Labels/Score.set_text(str(score))
	if SaveScript.is_file_there():
		high_score = SaveScript.load_val()
		$Labels/HighScore.set_text("High Score: " + str(high_score))
	$GameStartCountdownTimer.start()

func _on_GameStartCountdownTimer_timeout():
	$Labels/GoLabel.hide()
	$WatermelonTimer.start()
	$BaconTimer.start()
	$HourglassTimer.start()
	$GameTimer.start()
	
func _on_GameTimer_timeout():
	timer += -1
	$Labels/GameTimerLabel.set_text(str(timer))

func update_watermelon():
	score += 1
	$Labels/Score.set_text(str(score))

func update_bacon():
	score -= 1
	$Labels/Score.set_text(str(score))

func update_hourglass():
	if timer > 0:
		timer += 5
		$Labels/GameTimerLabel.set_text(str(timer))
	

func _on_WatermelonTimer_timeout():
	# create a new instance of watermelon scene
	var enemy = watermelon_scene.instance()
	
	# random location to spawn watermelon
	var watermelon_spawn_location = get_node("EnemyPath/EnemySpawnPoint")
	watermelon_spawn_location.offset = randi()
	
	add_child(enemy)
	enemy.position = $EnemyPath/EnemySpawnPoint.position
	enemy.connect("watermelon", self, "update_watermelon")

func _on_BaconTimer_timeout():
	var enemy = bacon_scene.instance()
	
	var bacon_spawn_location = get_node("EnemyPath/EnemySpawnPoint")
	bacon_spawn_location.offset = randi()
	
	add_child(enemy)
	enemy.position = $EnemyPath/EnemySpawnPoint.position
	enemy.connect("bacon", self, "update_bacon")
	
func _on_HourglassTimer_timeout():
	var enemy = hourglass_scene.instance()
	
	var hourglass_spawn_location = get_node("EnemyPath/EnemySpawnPoint")
	hourglass_spawn_location.offset = randi()
	
	add_child(enemy)
	enemy.position = $EnemyPath/EnemySpawnPoint.position
	enemy.connect("hourglass", self, "update_hourglass")

func end_game():
	$WatermelonTimer.stop()
	$BaconTimer.stop()
	$HourglassTimer.stop()
	$GameTimer.stop()
	$Labels/FinalScore.set_text("Your Score: " + str(score))
	$Labels/FinalScore.show()
	$Labels/Retry.show()
	if high_score:
		if high_score < score:
			SaveScript.save_val(score)
			$Labels/NewHighScore.show()
	else:
		SaveScript.save_val(score)
		$Labels/NewHighScore.show()

func _on_Main_tree_exiting():
	# save high score
	if high_score:
		if high_score < score:
			SaveScript.save_val(score)
	else:
		SaveScript.save_val(score)
