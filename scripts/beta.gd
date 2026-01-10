extends CharacterBody2D

const current_speed = 50.0

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
	var beta_colors : Array =[Color(0.6, 0.11, 0.10,1),Color(0.29, 0.69, 0.74),Color(0.1, 0.4, 0.65),Color(0.25,0.26,0.28),Color(0.77, 0.67, 0.43),Color(0.05, 0.1, 0.45),Color(0.23,0.16,0.18),Color(0.15,0,0.4)]
	
	set_palette(randi()%4,beta_colors.pick_random())

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
			
func set_palette(index : int, color : Color) :
	################################
	##One Colour->8 Colour Palette##
	################################
	# index currently set to 0 by default, will later be a drop down that gives types of palettes. For now, monochrome only.
	
	var palette_colors : Array = []
	#var colors: Array[Color] = []
	print("index: ",index)
	
	if index==0 : #monochromatic palette
		palette_colors = monochromatic_palette(color)
	if index == 1: #All One Colour
		print("color: ",color)
		palette_colors = set_random()
		print("palette_colors: ",palette_colors)
	if index == 2: #Analagous Palette
		palette_colors = analagous_palette(color)
	if index == 3: #Complementary
		palette_colors = complementary_palette(color)
	if index == 4: #Split Complementary
		palette_colors = splitComplementary_palette(color)
	if index == 5: #Triadiac
		palette_colors = triadiac_palette(color)
	if index == 6: #Tetradic
		palette_colors = tetradic_palette(color)
	
	set_all_colours(palette_colors)
		


func set_all_colours(set_colours_array : Array) -> void:
	$AnimatedSprite2D.material.set_shader_parameter("ReplaceRed", set_colours_array[0])
	$AnimatedSprite2D.material.set_shader_parameter("ReplaceGre", set_colours_array[1])
	$AnimatedSprite2D.material.set_shader_parameter("ReplaceBlu", set_colours_array[2])
	$AnimatedSprite2D.material.set_shader_parameter("ReplaceYel", set_colours_array[3])
	$AnimatedSprite2D.material.set_shader_parameter("ReplaceCya", set_colours_array[4])
	$AnimatedSprite2D.material.set_shader_parameter("ReplaceMag", set_colours_array[5])
	$AnimatedSprite2D.material.set_shader_parameter("ReplaceBla", set_colours_array[6])
	$AnimatedSprite2D.material.set_shader_parameter("ReplaceWhi", set_colours_array[7])

func set_random() -> Array:
	################################
	##Randomize Replacment Colours##
	################################
	var set_colours_array : Array = [ Color(randf(), randf(),  randf(), 1.0), Color(randf(), randf(),randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0), Color(randf(), randf(), randf(), 1.0)]
	print(set_colours_array)
	return set_colours_array


func monochromatic_palette(color : Color) -> Array:
	## Monochromatic. This Palette Takes the given clour and generates 8 evenly spaced colours
	# Get the base color's HSV components
	# Godot's Color class has h, s, v properties built-in (since at least Godot 3.2)
	var base_hue: float = color.h
	var base_saturation: float = color.s
	var colors : Array = []

	for i in range(8):
		# Generate a random 'value' (brightness/lightness) between 0.0 (black) and 1.0 (white)
		# Using randf() ensures a float value in the range [0.0, 1.0]
		var random_value: float = randf()

		# Create a new color using the base hue and saturation, but the random value
		var new_color: Color = Color.from_hsv(base_hue, base_saturation, random_value, color.a)
		
		colors.append(new_color)
	return colors

func analagous_palette(color : Color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#analagous
	var colors: Array[Color] = []
	# Provided colour is the Dominant Colour
	colors.append(color)
	# We want to grab the hue from it (hue is float ranging from 0 to 1, both of which are read) and ready a couple of copies of the og colour to have their hue modified slightly
	var base_hue: float = color.h
	var color_neighbor_1 : Color = color
	var color_neighbor_2: Color = color
	var color_neutral_0 : Color = color
	var color_neutralX_0 : Color = color
	var color_neutral_1 : Color = color
	var color_neutralX_1 : Color = color
	var color_neutral_2 : Color = color
	# the we want to grab a couple neighboring colours within .125 of the og hue (this is a quarter of the colour wheel, an eight to either side), making sure to mod it so it doesn't go over one. wrapf(hue_value, 0.0, 1.0)
	### create neighbor colour 1
	color_neighbor_1.h  = base_hue + wrapf(randf_range(-0.125,0.125), 0.0, 1.0)
	color_neutral_1 = color_neighbor_1
	colors.append(color_neighbor_1)
	
	### create neighbor colour 2
	color_neighbor_2.h  = wrapf(base_hue + randf_range(-0.125,0.125), 0.0, 1.0)
	color_neutral_2 = color_neighbor_2
	colors.append(color_neighbor_2)
	
	#make the rest of the colours neutral versions of the existing generated colours
	
	# dominant with low saturation
	#add two colours, dominant hue with 1/2 and 1/4 og saturation
	color_neutral_0.s = color.s/2
	colors.append(color_neutral_0)
	
	color_neutralX_0.s = color.s/4
	colors.append(color_neutral_0)
	
	#add two colours, neighbor 1 hue with 1/2 and 1/4 og saturation
	color_neutral_1.s = color_neighbor_1.s/2
	colors.append(color_neutral_1)
	
	color_neutralX_1.s = color_neighbor_1.s/4
	colors.append(color_neutral_1)
	
	#add one final colours, neighbor 2 hue with 1/2 og saturation
	color_neutral_2.s = color_neighbor_2.s/2
	colors.append(color_neutral_2)
	
	colors.shuffle()
	
	return colors

func complementary_palette(dominant : Color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#complementary_palette - new palette just dropped
	var colors: Array[Color] = []
	# Provided colour is the Dominant Colour
	colors.append(dominant)
	# We want to grab the hue from it (hue is float ranging from 0 to 1, both of which are read) and ready a couple of copies of the og colour to have their hue modified slightly
	var dominant_lowerV : Color = dominant
	var dominant_lowerS : Color = dominant
	
	var dominant_shade : Color = dominant
	var dominant_grey_highV_lowS : Color = dominant
	var dominant_grey_lowV_lowS : Color = dominant
	
	var complement_bright : Color = dominant
	var complement_dull : Color = dominant
	
	### create two harmonious colours 
	dominant_lowerV.v = dominant.v/2
	colors.append(dominant_lowerV)
	
	dominant_lowerS.s = dominant.s/2
	colors.append(dominant_lowerS)
	
	# Dark shade
	dominant_shade.s = clamp(dominant.s + (1-dominant.s)/2, 0.0, 1.0)
	dominant_shade.v = clamp(dominant.v/4, 0.0, 1.0)
	colors.append(dominant_shade)
	
	# Near white
	dominant_grey_highV_lowS.s = randf_range(0.00,0.1)
	dominant_grey_highV_lowS.v = randf_range(0.8,0.95)
	colors.append(dominant_grey_highV_lowS)
	
	# Near black
	dominant_grey_lowV_lowS.s = randf_range(0.05,0.2)
	dominant_grey_lowV_lowS.v = randf_range(0.05,0.2)
	colors.append(dominant_grey_lowV_lowS)
	
	
	### create complementary colour & a lower saturation/value version of it
	complement_bright.h  = wrapf(dominant.h + 0.5 + randf_range(-0.05,0.05), 0.0, 1.0)
	complement_bright.s  = dominant.s*randf_range(0.8,0.9)
	complement_bright.v  = dominant.v*randf_range(0.8,0.9)
	colors.append(complement_bright)
	
	### create a lower saturation/value version of the complement
	complement_dull = complement_bright
	complement_dull.s = complement_bright.s*randf_range(0.45,0.6)
	complement_dull.v = complement_bright.v*randf_range(0.45,0.6)
	colors.append(complement_dull)
	#colors.shuffle()
	
	return colors

func splitComplementary_palette(color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#Split Complementary
	var colors : Array = [Color(),color,Color(),Color(),Color(),Color(),Color(),Color()]
	return colors

func triadiac_palette(color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#Triadiac
	var colors : Array = [Color(),Color(),color,Color(),Color(),Color(),Color(),Color()]
	return colors

func tetradic_palette(color) -> Array:
	################################
	##One Colour->8 Colour Palette##
	################################
	#Tetradic
	var colors : Array = [Color(),Color(),Color(),color,Color(),Color(),Color(),Color()]
	return colors
	
func shuffle_colors() -> void:
	################################
	##Randomize Replacment Colours##
	################################
	#This function grabs all the current colours set in the colour sliders, then mixes them all up (by suffling, then calling the function which sets the sliders to the new colours and thereby updates the shader values)
	var set_colours_array : Array = []
	set_colours_array.append($AnimatedSprite2D.material.get_shader_parameter("ReplaceRed"))
	set_colours_array.append($AnimatedSprite2D.material.get_shader_parameter("ReplaceGre"))
	set_colours_array.append($AnimatedSprite2D.material.get_shader_parameter("ReplaceBlu"))
	set_colours_array.append($AnimatedSprite2D.material.get_shader_parameter("ReplaceYel"))
	set_colours_array.append($AnimatedSprite2D.material.get_shader_parameter("ReplaceCya"))
	set_colours_array.append($AnimatedSprite2D.material.get_shader_parameter("ReplaceMag"))
	set_colours_array.append($AnimatedSprite2D.material.get_shader_parameter("ReplaceBla"))
	set_colours_array.append($AnimatedSprite2D.material.get_shader_parameter("ReplaceWhi"))
	set_colours_array.shuffle()
	set_all_colours(set_colours_array)
