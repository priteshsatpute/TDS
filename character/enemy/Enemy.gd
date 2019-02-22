extends KinematicBody2D

var item_type = "player"
var speed = 130
var is_attack = false
var is_motion = false
var current_weapon = "knife"
var health = 100
var weapons_list = []
var is_weapon = null
var bullets = [[30,30],[10,10]]
var bullet = load("res://models/ammo/bullets/bullets.tscn")
slave var motion = Vector2();

func _ready():
	$AnimatedSprite.play("knife_idle")
	get_viewport().audio_listener_enable_2d = true
	$AudioStreamPlayer2D2.stream = load("res://character/assets/sounds/footsteps-4.wav")
	
func _process(delta):
	is_motion = false
	motion = Vector2(0,0)
	$Muzzle/Sprite.hide()
	move_and_slide(motion,Vector2(0,0))
	if(health <= 0):
		queue_free()
	
