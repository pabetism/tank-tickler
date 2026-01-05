extends CharacterBody2D

const current_speed = 80.0

# Export the speed to easily adjust it in the editor
#@export var speed: float = 80.0
# Define the initial velocity (direction and magnitude)
var current_velocity: Vector2 = Vector2(300, 200).normalized() * current_speed

# Define your bounds
var min_x: float = 10.0
var max_x: float = 1014.0
var min_y: float = 10.0
var max_y: float = 590.0

func _ready():
	# Optional: Initialize the random number generator once per game launch
	# This is often done in a main game script.
	

	# Generate random coordinates within the bounds
	var random_x: float = randf_range(min_x, max_x)
	var random_y: float = randf_range(min_y, max_y)
	
	# Set the object's position
	self.position = Vector2(random_x, random_y)

	current_velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * current_speed

func _physics_process(delta: float):
	# Move the object and check for collisions
	var collision_info = move_and_collide(current_velocity * delta)

	# If a collision occurred, bounce the velocity vector
	if collision_info:
		# Use the bounce function to reflect the velocity based on the collision normal
		current_velocity = current_velocity.bounce(collision_info.get_normal())
		# Optional: You can add a small speed boost or reduction here if desired
