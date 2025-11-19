extends Area2D
var direction
var speed = 300
var maxtimer = 3
var timer = maxtimer
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func _physics_process(delta):
	position += direction * speed * delta
func set_direction(_target):
	direction = position.direction_to(_target)
	if direction.x < 0:
		scale *= -1

	  
func _on_body_entered(body):
	if body.name == "Player":
		body.change_health(-2)
		queue_free()
	pass
