extends Node2D

onready var health_bar = $HealthBar/TextureProgress
onready var heat_bar = $HeatBar/TextureProgress
onready var tween = $Tween
var animated_health = 0
var animated_heat = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var hero_max_health = $"../Hero".max_health
	var hero_max_heat = $"../Hero".max_heat
	health_bar.max_value = hero_max_health
	health_bar.max_value = hero_max_heat
	update_health(hero_max_health)
	update_heat(0)


func update_health(new_health):
	tween.interpolate_property(self, "animated_health", animated_health, new_health, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
	animated_health = new_health
		
func update_heat(new_heat):
	tween.interpolate_property(self, "animated_heat", animated_heat, new_heat, 0.01, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()
	animated_heat = new_heat
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _process(delta):
	health_bar.value = animated_health
	heat_bar.value = animated_heat


func _on_Hero_health_change(health):
	update_health(health)


func _on_Hero_heat_change(heat):
	update_heat(heat)
