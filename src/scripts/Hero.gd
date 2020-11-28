extends KinematicBody2D

export (int) var speed = 400
export (float) var rotation_speed = 1.5
var screen_size
var rotation_dir
var velocity

var dotBullet = preload("res://src/nodes/dotBullet.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func shoot():
	var bullet = dotBullet.instance()
	bullet.start(position, rotation)
	# add to root node
	self.get_tree().get_root().add_child(bullet)
	

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		rotation_dir += 1
	if Input.is_action_pressed('ui_left'):
		rotation_dir -= 1
	if Input.is_action_pressed('ui_down'):
		velocity = Vector2(0, speed).rotated(rotation)
	if Input.is_action_pressed('ui_up'):
		velocity = Vector2(0, -speed).rotated(rotation)
	if Input.is_action_pressed("attack"):
		shoot()
		

func _physics_process(delta):
	get_input()
	if velocity.length() > 0:
		$AnimatedSprite.play("0_speedup")
	else:
		$AnimatedSprite.play("0_speeddown")
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
	
