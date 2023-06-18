extends Node

var score

func _ready():
	new_game()
	$Watermelon.connect("watermelon", self, "update_watermelon") # signal, where to connect to, function to use
	$Bacon.connect("bacon", self, "update_bacon")

func new_game():
	score = 0
	
func update_watermelon():
	score += 1
	$Control/Score.set_text(str(score))

func update_bacon():
	score -= 1
	$Control/Score.set_text(str(score))


func _on_WatermelonTimer_timeout():
	var watermelon_scene = load("res://enemy/Watermelon.tscn")
	# create a new instance of watermelon scene
	var enemy = watermelon_scene.instance()
	
	# random location to spawn watermelon
	var watermelon_spawn_location = get_node("EnemyPath/EnemySpawnPoint")
	watermelon_spawn_location.offset = randi()
	
	add_child(enemy)
	enemy.position = $EnemyPath/EnemySpawnPoint.position
	enemy.connect("watermelon", self, "update_watermelon")

func _on_BaconTimer_timeout():
	var bacon_scene = load("res://enemy/Bacon.tscn")
	var enemy = bacon_scene.instance()
	
	var bacon_spawn_location = get_node("EnemyPath/EnemySpawnPoint")
	bacon_spawn_location.offset = randi()
	
	add_child(enemy)
	enemy.position = $EnemyPath/EnemySpawnPoint.position
	enemy.connect("bacon", self, "update_bacon")
