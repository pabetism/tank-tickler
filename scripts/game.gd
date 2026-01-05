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
	var menu_scene: PackedScene = load("res://scenes/MainMenu.tscn")# preload player tetra
	var menu_new: Node2D = menu_scene.instantiate()# instantiate player tetra
	add_child(menu_new)# add player tetra as childnode to Game
	menu_new.owner = self
	menu_new.name = "mainmenu"
	print(menu_new)

func _process(delta: float) -> void :
	var current_children = self.get_children()
	if current_children.has("tank") :
		pass
	elif  current_children.has("mainmenu") :
		pass
	else :
		print("Adding Menu.")
		add_menu()
