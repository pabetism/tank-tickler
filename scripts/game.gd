extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	add_tank()

func add_tank() -> void :
	var tank_scene: PackedScene = load("res://scenes/tank.tscn")# preload player tetra
	var tank_new: StaticBody2D = tank_scene.instantiate()# instantiate player tetra
	add_child(tank_new)# add player tetra as childnode to Game
	tank_new.owner = self
	tank_new.name = "tank"
	
func add_menu() -> void :
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _process(delta: float) -> void :
	var current_children : Array = self.get_children()
	var children_names : Array = []
	for child in current_children :
		children_names.append(child.get_name())
		
	if children_names.has("tank") :
		pass
	elif  children_names.has("mainmenu") :
		pass
	else :
		print("Adding Menu.")
		add_menu()
