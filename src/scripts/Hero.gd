extends KinematicBody2D

export (int) var speed = 400
export (float) var rotation_speed = 1.5

var max_health = 100
var max_heat = 100

export var health = 100
export var heat = 0

var screen_size
var rotation_dir
var velocity

var dotBullet = preload("res://src/nodes/dotBullet.tscn")

signal health_change
signal heat_change


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


func shoot():
	if heat < max_heat:
		var bullet = dotBullet.instance()
		bullet.start(position, rotation)
		# add to root node
		self.get_tree().get_root().add_child(bullet)
		heat += 2
		emit_signal("heat_change", heat)
	else:
		$"HeatFull".play()
		
	

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
	elif !Input.is_action_pressed("attack"):
		heat -= 1
		emit_signal("heat_change", heat)
		

func _physics_process(delta):
	get_input()
	if velocity.length() > 0:
		$AnimatedSprite.play("0_speedup")
	else:
		$AnimatedSprite.play("0_speeddown")
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)
	if position.x < 0:
		position.x = screen_size.x
	elif position.x > screen_size.x:
		position.x = 0
	if position.y < 0:
		position.y = screen_size.y
	elif position.y > screen_size.y:
		position.y = 0

	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
