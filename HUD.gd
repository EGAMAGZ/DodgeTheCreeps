extends CanvasLayer

# Tells the Main node that the button has been pressed
signal start_game 

# This function is called when we want to display a message temporaly
func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	#function is called when the player loses. 
	# It will show "Game Over" for 2 seconds, then return to the title screen 
	# and, after a brief pause, show the "Start" button.
	show_message("Game Over")
	# Wait until the MessageTimer has counted down
	yield($MessageTimer, "timeout")
	
	$Message.text = "Dodge the\nCreeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func update_score(score):
	# Function called by Main when score changes
	$ScoreLabel.text = str(score)
	


func _on_MessageTimer_timeout():
	$Message.hide()


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
