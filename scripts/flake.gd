extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("A Wild Flake Appears!") 

func _on_body_entered(body: Node2D) -> void:
	print("yum!") # Replace with function body.
	queue_free()
