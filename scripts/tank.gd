extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.name = "tank"
	add_add_button()
	add_remove_button()
	add_close_tank_button()
	add_fish()
	add_fish()
	add_fish()
	
	
	var addButton_node = get_node('AddFish')
	addButton_node.pressed.connect(add_fish)
	
	var removeButton_node = get_node('RemoveFish')
	removeButton_node.pressed.connect(remove_fish_from_tank)
	
	var closeTankButton_node = get_node('CloseTank')
	closeTankButton_node.pressed.connect(close_take)
	
	#var AcceptDialogue_node = get_node('AcceptDialog')
	#AcceptDialogue_node.pressed.connect(remove_fish_from_tank)

func add_close_tank_button() -> void:
	var AddMainMenuButton_scene: PackedScene = load("res://scenes/button_returnToMenu.tscn")# preload CharacterBody2D tetra
	var AddMainMenuButton_new: TextureButton = AddMainMenuButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(AddMainMenuButton_new)# add CharacterBody2D tetra as childnode to Game
	AddMainMenuButton_new.owner = self
	AddMainMenuButton_new.name = "CloseTank"
	
	
func remove_fish_from_tank() -> void:
	var found_child = $".".find_child('Fish*')
	if found_child != null :
		found_child.queue_free()
	else:
		$AcceptDialog.dialog_text = "No fish!"
		$AcceptDialog.popup_centered()


func add_fish() -> void:
	var fish_children = []
	for child in $".".get_children():
		if child.name.begins_with('Fish') :
			fish_children.append(child)

	
	if fish_children.size() <= 5 :
		var blueAnimatedTetra_scene: PackedScene = load("res://scenes/fish.tscn")# preload CharacterBody2D tetra
		var blueAnimatedTetra_new: CharacterBody2D = blueAnimatedTetra_scene.instantiate()# instantiate CharacterBody2D tetra
		add_child(blueAnimatedTetra_new)# add CharacterBody2D tetra as childnode to Game
		blueAnimatedTetra_new.owner = self
		blueAnimatedTetra_new.name = "Fish"
	else:
		$AcceptDialog.dialog_text = "Many fish!"
		$AcceptDialog.popup_centered()
	
func add_add_button() -> void:
	var AddAfishButton_scene: PackedScene = load("res://scenes/button_addFish.tscn")# preload CharacterBody2D tetra
	var AddFishButton_new: TextureButton = AddAfishButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(AddFishButton_new)# add CharacterBody2D tetra as childnode to Game
	AddFishButton_new.owner = self

	
func add_remove_button() -> void:

	var RemovefishButton_scene: PackedScene = load("res://scenes/button_removeFish.tscn")# preload CharacterBody2D tetra
	var RemoveFishButton_new: TextureButton = RemovefishButton_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(RemoveFishButton_new)# add CharacterBody2D tetra as childnode to Game
	RemoveFishButton_new.owner = self

	

func close_take() -> void:
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
