extends KinematicBody2D

var speed = 120
var is_attack = false
var is_motion = false
var current_weapon = "knife"

func _ready():
	$AnimatedSprite.play("knife_idle")
	get_viewport().audio_listener_enable_2d = true
	$AudioStreamPlayer2D.play()
	pass

func _process(delta):
	if(Input.is_action_pressed("rifle")):
		current_weapon = "rifle"
		$AnimatedSprite.play("rifle_idle")
	if(Input.is_action_pressed("handgun")):
		current_weapon = "handgun"
		$AnimatedSprite.play("handgun_idle")
	if(Input.is_action_pressed("knife")):
		current_weapon = "knife"
		$AnimatedSprite.play("knife_idle")
	
	if(Input.is_action_pressed("attack")):
		is_attack = true
		$AnimatedSprite.play(current_weapon+"_attack")

	if(Input.is_action_pressed("ui_up")):
		is_motion = true
		move_and_slide(Vector2(0,-speed),Vector2(0,0))
		if(!is_attack):
			$AnimatedSprite.play(current_weapon+"_move")
		
	if(Input.is_action_pressed("ui_down")):
		is_motion = true
		move_and_slide(Vector2(0,speed),Vector2(0,0))
		if(!is_attack):
			$AnimatedSprite.play(current_weapon+"_move")
		
	if(Input.is_action_pressed("ui_left")):
		is_motion = true
		move_and_slide(Vector2(-speed,-0),Vector2(0,0))
		if(!is_attack):
			$AnimatedSprite.play(current_weapon+"_move")
		
	if(Input.is_action_pressed("ui_right")):
		is_motion = true
		move_and_slide(Vector2(speed,0),Vector2(0,0))
		if(!is_attack):
			$AnimatedSprite.play(current_weapon+"_move")

	look_at(get_viewport().get_mouse_position())

func _on_AnimatedSprite_animation_finished():
	is_motion = false
	is_attack = false
	$AnimatedSprite.play(current_weapon+"_idle")

