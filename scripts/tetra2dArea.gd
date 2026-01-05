extends Area2D

const current_speed = 100.0

# Export the speed to easily adjust it in the editor
#@export var speed: float = 80.0
# Define the initial velocity (direction and magnitude)
var current_velocity: Vector2 = Vector2(300, 200).normalized() * current_speed

# Define your bounds
var min_x: float = 00.0
var max_x: float = 640.0
var min_y: float = 00.0
var max_y: float = 360.0

func _ready():
	# Optional: Initialize the random number generator once per game launch
	# This is often done in a main game script.
	randomize() 

	# Generate random coordinates within the bounds
	var random_x: float = randf_range(min_x, max_x)
	var random_y: float = randf_range(min_y, max_y)
	
	# Set the object's position
	self.position = Vector2(random_x, random_y)

	current_velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * current_speed


func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	print("BYE!") 
	get_tree().reload_current_scene()
