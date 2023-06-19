extends MarginContainer

const instructions_scene = preload("res://instructions/Instructions.tscn")
const main_scene = preload("res://Main.tscn")

onready var selector_one = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer/HBoxContainer/Selector
onready var selector_two = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/Selector
onready var selector_three = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer3/HBoxContainer/Selector

var current_selection = 0
var high_score

func _ready():
	set_current_selection(0)
	if SaveScript.is_file_there():
		high_score = SaveScript.load_val()
		print(high_score)
	else:
		print("no file there")
		
	
func _process(delta):
	if Input.is_action_just_pressed("ui_down") and current_selection < 2:
		current_selection += 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_down") and current_selection == 2:
		current_selection -= 2
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection > 0:
		current_selection -= 1
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_up") and current_selection == 0:
		current_selection += 2
		set_current_selection(current_selection)
	elif Input.is_action_just_pressed("ui_accept"):
		handle_selection(current_selection)
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		
func handle_selection(_current_selection):
	if _current_selection == 0:
		get_parent().add_child(main_scene.instance())
	elif _current_selection == 1:
		get_parent().add_child(instructions_scene.instance())
		queue_free()
	elif _current_selection == 2:
		get_tree().quit()

func set_current_selection(_current_selection):
	selector_one.text = ""
	selector_two.text = ""
	selector_three.text = ""
	
	if _current_selection == 0:
		selector_one.text = ">"
	elif _current_selection == 1:
		selector_two.text = ">"
	elif _current_selection == 2:
		selector_three.text = ">"
		
