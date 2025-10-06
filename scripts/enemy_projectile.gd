extends Area2D
var direction
var speed = 300
var maxtimer = 3
var timer = maxtimer
func _ready() -> void:
	body_entered.connect(_on_body_entered)
func set_direction(_target):
	direction = position.direction_to(_target)
	
	  
func _on_body_entered(body):
	if body.name == "Player":
		body.change_health(-2)
	pass
func _physics_process(_delta):
	position += direction * speed * _delta
func process(delta):
	timer -= delta
	if timer <0:
		queue_free()
