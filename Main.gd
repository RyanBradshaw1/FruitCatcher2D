extends Node

var score
var high_score
var watermelon_scene = preload("res://enemy/Watermelon.tscn")
var bacon_scene = preload("res://enemy/Bacon.tscn")

func _ready():
	new_game()
	if SaveScript.is_file_there():
		high_score = SaveScript.load_val()
		print(high_score)
		$Control2/HighScore.set_text("High Score: " + str(high_score))
	else:
		print("no file there")
	$Watermelon.connect("watermelon", self, "update_watermelon") # signal, where to connect to, function to use
	$Bacon.connect("bacon", self, "update_bacon")

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func new_game():
	score = 0
	
func update_watermelon():
	score += 1
	$Control/Score.set_text(str(score))

func update_bacon():
	score -= 1
	$Control/Score.set_text(str(score))


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

func _on_Main_tree_exiting():
	print("exited")
	if high_score:
		if high_score < score:
			SaveScript.save_val(score)
	elif !high_score:
		SaveScript.save_val(score)
	# if no high score, save score as high score
	# if high score is less than score, save high score
	# if high score is more than score, don't save
