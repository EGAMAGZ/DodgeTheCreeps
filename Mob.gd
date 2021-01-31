extends RigidBody2D

export var min_speed = 150
export var max_speed = 250

func _ready():
	var mob_types = $AnimatedSprite.frames.get_animation_names() # Return array with the sprites' name
	$AnimatedSprite.animation = mob_types[randi() % mob_types.size()] # Select random mob


func _on_VisibilityNotifier2D_screen_exited():
	# Funtion connected with VisibilityNotifier, to delete enemy whe is out of screen
	queue_free()
