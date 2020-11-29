extends Area2D


export var speed = 1000
var velocity = Vector2(0, -speed)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# called by ship
func start(pos, dir):
	position = pos
	rotation = dir
	velocity = velocity.rotated(rotation)
	$AudioStreamPlayer.play()

func _process(delta):
	position += velocity * delta


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# bullet outside of screen
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_dotBullet_body_entered(body):
	if body.has_method("handle_hit"):
		body.handle_hit()
		queue_free()
