extends AnimatedSprite2D


# var targetcolors =  [Color(1.0, 0.0, 0.0, 1.0),Color(0.0, 1.0, 0.0, 1.0), Color(0.0, 0.0, 1.0, 1.0),Color(1.0, 1.0, 0.0, 1.0),Color(0.0, 1.0, 1.0, 1.0), Color(1.0, 0.0, 1.0, 1.0),Color(1.0, 1.0, 1.0, 1.0), Color(0.0, 0.0, 0.0, 1.0)]

var colors = [Color(1.0, 0.5, 0.0, 1.0),Color(0.0, 1.0, 0.0, 1.0)]

var fish_color =  Color(0.0, 1.0, 0.0, 1.0);

func _ready():
	#var fish_color = colors.pick_random()

	material.set_shader_parameter("replace_color",Color(0.0, 1.0, 0.0, 1.0))
