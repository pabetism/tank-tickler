extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_new_game_button()
	#add_load_game_button()
	#add_high_score_button()
	
	var new_game_node = get_node('NewGame')
	#var load_game_node = get_node('LoadGame')
	#var high_score = get_node('HighScore')
	new_game_node.pressed.connect(NewGame)
	#load_game_node.pressed.connect(LoadGame)
	#high_score.pressed.connect(HighScore)
	

func NewGame() -> void:
	$AcceptDialog.dialog_text = "If only!"
	$AcceptDialog.popup_centered()

func LoadGame() -> void:
	$AcceptDialog.dialog_text = "If only!"
	$AcceptDialog.popup_centered()

func HighScore() -> void:
	$AcceptDialog.dialog_text = "If only!"
	$AcceptDialog.popup_centered()

func add_new_game_button() -> void:
	var NewGameButton_scene: PackedScene = load("res://scenes/button_new_game.tscn")# preload CharacterBody2D tetra
	var NewGameButton_new: TextureButton = NewGameButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(NewGameButton_new)# add CharacterBody2D tetra as childnode to Game
	NewGameButton_new.owner = self
	NewGameButton_new.name = "NewGame"
	
func add_load_game_button() -> void:
	var LoadGameButton_scene: PackedScene = load("res://scenes/button_load_game.tscn")# preload CharacterBody2D tetra
	var LoadGameButton_new: TextureButton = LoadGameButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(LoadGameButton_new)# add CharacterBody2D tetra as childnode to Game
	LoadGameButton_new.owner = self

func add_high_score_button() -> void:
	var HighScoreButton_scene: PackedScene = load("res://scenes/button_load_game.tscn")# preload CharacterBody2D tetra
	var HighScoreButton_new: TextureButton = HighScoreButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(HighScoreButton_new)# add CharacterBody2D tetra as childnode to Game
	HighScoreButton_new.owner = self
