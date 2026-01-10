extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_new_game_button()
	add_load_game_button()
	add_high_score_button()
	add_exit_game_button()
	
	var new_game_node = get_node('NewGame')
	var load_game_node = get_node('LoadGame')
	var high_score_node = get_node('HighScore')
	var exit_game_node = get_node('ExitGame')
	new_game_node.pressed.connect(NewGame)
	load_game_node.pressed.connect(LoadGame)
	high_score_node.pressed.connect(HighScore)
	exit_game_node.pressed.connect(ExitGame)
	

func NewGame() -> void:
	get_tree().change_scene_to_file("res://scenes/game.tscn")

func LoadGame() -> void:
	$AcceptDialog.dialog_text = "No data?!"
	$AcceptDialog.popup_centered()

func HighScore() -> void:
	$AcceptDialog.dialog_text = "From What games?!"
	$AcceptDialog.popup_centered()


func ExitGame():
	# This function is connected to the "pressed()" signal of your Button node.
	# Use get_tree().quit() to close the entire application
	get_tree().quit()

func add_new_game_button() -> void:
	var NewGameButton_scene: PackedScene = load("res://scenes/button_new_game.tscn")# preload CharacterBody2D tetra
	var NewGameButton_new = NewGameButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(NewGameButton_new)# add CharacterBody2D tetra as childnode to Game
	NewGameButton_new.owner = self
	NewGameButton_new.name = "NewGame"
	
func add_load_game_button() -> void:
	var LoadGameButton_scene: PackedScene = load("res://scenes/button_load_game.tscn")# preload CharacterBody2D tetra
	var LoadGameButton_new = LoadGameButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(LoadGameButton_new)# add CharacterBody2D tetra as childnode to Game
	LoadGameButton_new.owner = self
	LoadGameButton_new.name = "LoadGame"

func add_high_score_button() -> void:
	var HighScoreButton_scene: PackedScene = load("res://scenes/button_high_score.tscn")# preload CharacterBody2D tetra
	var HighScoreButton_new = HighScoreButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(HighScoreButton_new)# add CharacterBody2D tetra as childnode to Game
	HighScoreButton_new.owner = self
	HighScoreButton_new.name = "HighScore"

func add_exit_game_button() -> void:
	var ExitGameButton_scene: PackedScene = load("res://scenes/button_exit_game.tscn")# preload CharacterBody2D tetra
	var ExitGameButton_new = ExitGameButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(ExitGameButton_new)# add CharacterBody2D tetra as childnode to Game
	ExitGameButton_new.owner = self
	ExitGameButton_new.name = "ExitGame"
	
