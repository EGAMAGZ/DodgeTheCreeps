extends Area2D
signal hit # Will define a custom signal called hit

export var speed = 400 # Speed (px/sec)
var screen_size # Size of the screen game

func _ready():
	# Function called when a node enters teh secene tree
	screen_size = get_viewport_rect().size
	
	hide()

func _process(delta):
	# Function is called every frame
	var velocity = Vector2() # Player's movement vector
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		# Velocity is normalized to prevent the player move faster by moving in diagonal
		velocity = velocity.normalized() * speed # Normalized will return 1 as length
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	# To prevent the user get out of the screen, it's used clamp()
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		
		$AnimatedSprite.flip_h = velocity.x < 0 
	
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func _on_Player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true) # Disables player's collision
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
