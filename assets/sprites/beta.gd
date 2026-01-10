extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.name = "tank"
	#Add buttons
	add_add_button()
	add_remove_button()
	add_close_tank_button()
	add_change_tank_button()
	#Add fish
	start_add_fish_process()
	start_add_fish_process()
	start_add_fish_process()
	#Connect Buttons
	var addfishButton_node = get_node('AddFish')
	addfishButton_node.pressed.connect(start_add_fish_process)
	var removefishButton_node = get_node('RemoveFish')
	removefishButton_node.pressed.connect(remove_fish_from_tank)
	var closeTankButton_node = get_node('CloseTank')
	closeTankButton_node.pressed.connect(close_tank)
	var changeTankButton_node = get_node('ChangeTank')
	changeTankButton_node.pressed.connect(change_tank)

func add_change_tank_button() -> void:
	var AddChangeTankButton_new = Button.new()
	add_child(AddChangeTankButton_new)
	AddChangeTankButton_new.owner = self
	AddChangeTankButton_new.name = "ChangeTank"
	AddChangeTankButton_new.position = Vector2(600, 450)
	AddChangeTankButton_new.text = "Change Tank"

func add_close_tank_button() -> void:
	var AddCloseTankButton_new = Button.new()
	add_child(AddCloseTankButton_new)# add CharacterBody2D tetra as childnode to Game
	AddCloseTankButton_new.owner = self
	AddCloseTankButton_new.name = "CloseTank"
	AddCloseTankButton_new.position = Vector2(600, 250)
	AddCloseTankButton_new.text = "Close Tank"
	
func remove_fish_from_tank() -> void:
	var found_child = $".".find_child('Fish*')
	if found_child != null :
		found_child.queue_free()
	else:
		$AcceptDialog.dialog_text = "No fish!"
		$AcceptDialog.popup_centered()

func start_add_fish_process() -> void:
	var fish_children = []
	for child in $".".get_children():
		if child.name.begins_with('Fish') :
			fish_children.append(child)
	
	if fish_children.size() <= 15 :
		var fish_index_random : int = randi() %2
		if fish_index_random == 1 :
			create_tetra()
		else : 
			create_beta()
	else:
		$AcceptDialog.dialog_text = "Many fish!"
		$AcceptDialog.popup_centered()

func create_tetra() -> void:
	var blueAnimatedTetra_scene: PackedScene = load("res://scenes/fish.tscn")
	var blueAnimatedTetra_new: CharacterBody2D = blueAnimatedTetra_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(blueAnimatedTetra_new)# add CharacterBody2D tetra as childnode to Game
	blueAnimatedTetra_new.owner = self
	blueAnimatedTetra_new.name = "Fish"
	

func create_beta() -> void:
	var blueAnimatedTetra_scene: PackedScene = load("res://scenes/fish.tscn")# preload CharacterBody2D tetra
	var blueAnimatedTetra_new: CharacterBody2D = blueAnimatedTetra_scene.instantiate()# instantiate CharacterBody2D tetra
	add_child(blueAnimatedTetra_new)# add CharacterBody2D tetra as childnode to Game
	blueAnimatedTetra_new.owner = self
	blueAnimatedTetra_new.name = "Fish"

func add_add_button() -> void:
	var AddFishButton_new = Button.new() 
	add_child(AddFishButton_new)# add CharacterBody2D tetra as childnode to Game
	AddFishButton_new.owner = self
	AddFishButton_new.name = "AddFish"
	AddFishButton_new.position = Vector2(800, 50)
	AddFishButton_new.text = "Add Fish"

	
func add_remove_button() -> void:
	var RemoveFishButton_new = Button.new() 
	add_child(RemoveFishButton_new)
	RemoveFishButton_new.owner = self
	RemoveFishButton_new.name = "RemoveFish"
	RemoveFishButton_new.position = Vector2(700, 50)
	RemoveFishButton_new.text = "Remove Fish"

func change_tank() -> void:
	pass

func close_tank() -> void:
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
