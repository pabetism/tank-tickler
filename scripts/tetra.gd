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
	
	var colorSet1_options = [[Color(1.0, 0.5, 0.0, 1.0),Color(.5, 0.25, 0.0, 1.0)],[Color(0.0, 1.0, 0.0, 1.0),Color(0.0, 0.5, 0.0, 1.0)],[Color(0.0, 1.0, 1.0, 1.0),Color(0.0, 0.5, 0.5, 1.0)],[Color(1.0, 1.0, 0.0, 1.0),Color(0.5, 0.5, 0.0, 1.0)]]
	
	var colorSet2_options = [[Color(0.7, 0.23, 0.27, 1.0),Color(0.6, 0.15, 0.18, 1.0),Color(0.6, 0.6, 0.0, 1.0)],[Color(0.0, 0.7, 0.7, 1.0),Color(0.0, 0.5, 0.5, 1.0),Color(0.8, 0.3, 0.0, 1.0)]]
	
	var colorSet3_options = [[Color(.31, 0.4, 0.51, 1.0),Color(.69, 0.75, 0.82, 0.5)],[Color(.41, 0.4, 0.31, 1.0),Color(.89, 0.75, 0.62, 0.5)]]

	var colorSet1 =  colorSet1_options.pick_random();
	var colorSet2 =  colorSet2_options.pick_random();
	var colorSet3 =  colorSet3_options.pick_random();
	
	$AnimatedSprite2D.material.set_shader_parameter("colorSet_1pri",colorSet1[0])
	$AnimatedSprite2D.material.set_shader_parameter("colorSet_1sec",colorSet1[1])
	
	$AnimatedSprite2D.material.set_shader_parameter("colorSet_2pri",colorSet2[0])
	$AnimatedSprite2D.material.set_shader_parameter("colorSet_2sec",colorSet2[1])
	$AnimatedSprite2D.material.set_shader_parameter("colorSet_2ter",colorSet2[2])
	
	$AnimatedSprite2D.material.set_shader_parameter("colorSet_3pri",colorSet3[0])
	$AnimatedSprite2D.material.set_shader_parameter("colorSet_3sec",colorSet3[1])

	# Generate random coordinates within the bounds
	var random_x: float = randf_range(min_x, max_x)
	var random_y: float = randf_range(min_y, max_y)
	
	# Set the object's position
	self.position = Vector2(random_x, random_y)

	current_velocity = Vector2(randf_range(-1, 1),randf_range(-1, 1)).normalized() * current_speed

	if current_velocity.x > 0  :
			$AnimatedSprite2D.flip_h = false
	elif current_velocity.x < 0 :
			$AnimatedSprite2D.flip_h = true
	
func _physics_process(delta: float):
	# Move the object and check for collisions
	var collision_info = move_and_collide(current_velocity * delta)
	
	# If a collision occurred, bounce the velocity vector
	if collision_info:		# Use the bounce function to reflect the velocity based on the collision normal
		current_velocity = current_velocity.bounce(collision_info.get_normal())
		# Optional: You can add a small speed boost or reduction here if desired

		if current_velocity.x > 0 and current_velocity.y >= 0 :
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.rotation_degrees = 10 # right and down. looks good and 10?
		elif current_velocity.x >= 0 and current_velocity.y < 0 :
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.rotation = 0 # right and up
		elif current_velocity.x < 0 and current_velocity.y >= 0 :
			$AnimatedSprite2D.flip_h = true 
			$AnimatedSprite2D.rotation = 0 # left and down
		elif current_velocity.x <= 0 and current_velocity.y < 0 :
			$AnimatedSprite2D.flip_h = true 
			$AnimatedSprite2D.rotation = 0 #left and up
