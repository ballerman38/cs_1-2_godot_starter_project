extends Area2D
var lever2 = false
func _ready() -> void:
	pass

func _on_body_entered(body):
	pass
	# TODO: Check if the object that touched the coin is the player
	if body.name == "Player":
		body.change_coins(1)
		queue_free()
	
	
	# TODO: Print a message when the coin is collected
	
	
	
	# TODO: Remove the coin from the game
	
	
func password():
	if lever2 == true:
		print("password")
