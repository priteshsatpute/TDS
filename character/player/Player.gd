extends KinematicBody2D
var motion = Vector2(0,0)
var animation = "knife_idle"
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
func _ready():
	$AnimatedSprite.play("knife_idle")
	get_viewport().audio_listener_enable_2d = true
	$AudioStreamPlayer2D2.stream = load("res://character/assets/sounds/footsteps-4.wav")
	pass

func input():
	motion = Vector2(0,0)
	#Change Weapon
	if(Input.is_action_pressed("knife")):
		current_weapon = "knife"
		animation = "knife_idle"
		$AnimatedSprite.play("knife_idle")
	if(Input.is_action_pressed("rifle")):
		if(weapons_list.find("rifle") >= 0):
			current_weapon = "rifle"
			animation = "rifle_idle"
			$AnimatedSprite.play("rifle_idle")
	if(Input.is_action_pressed("handgun")):
		if(weapons_list.find("handgun") >= 0):
			current_weapon = "handgun"
			animation = "handgun_idle"
			$AnimatedSprite.play("handgun_idle")
	
	#Movements
	if(Input.is_action_pressed("ui_up")):
		is_motion = true
		motion = Vector2(0,-speed)
		move_and_slide(Vector2(0,-speed),Vector2(0,0))
		#rpc_unreliable("update_loc",get_tree().get_network_unique_id(),Vector2(0,-speed))
		if(!is_attack):
			animation = current_weapon+"_move"
			$AnimatedSprite.play(current_weapon+"_move")
			if(!$AudioStreamPlayer2D2.playing):
				$AudioStreamPlayer2D2.play()
	if(Input.is_action_pressed("ui_down")):
		is_motion = true
		motion = Vector2(0,speed)
		move_and_slide(Vector2(0,speed),Vector2(0,0))
		if(!is_attack):
			animation = current_weapon+"_move"
			$AnimatedSprite.play(current_weapon+"_move")
			if(!$AudioStreamPlayer2D2.playing):
				$AudioStreamPlayer2D2.play()
	if(Input.is_action_pressed("ui_left")):
		is_motion = true
		motion = Vector2(-speed,-0)
		move_and_slide(Vector2(-speed,-0),Vector2(0,0))
		if(!is_attack):
			animation = current_weapon+"_move"
			$AnimatedSprite.play(current_weapon+"_move")
			if(!$AudioStreamPlayer2D2.playing):
				$AudioStreamPlayer2D2.play()
	if(Input.is_action_pressed("ui_right")):
		is_motion = true
		motion = Vector2(speed,0)
		move_and_slide(Vector2(speed,0),Vector2(0,0))
		if(!is_attack):
			animation = current_weapon+"_move"
			$AnimatedSprite.play(current_weapon+"_move")
			if(!$AudioStreamPlayer2D2.playing):
				$AudioStreamPlayer2D2.play()
	#weapons
	if(Input.is_action_pressed("reload") and current_weapon!="knife"):
		is_motion = true
		is_attack = true
		if(bullets[0][1] > 0 and current_weapon=="rifle"):
			$AudioStreamPlayer2D.stream = load("res://character/assets/sounds/gun-cocking-03.wav")
			$AudioStreamPlayer2D.play() 
			if(bullets[0][1] >= (30 - bullets[0][0])):
				bullets[0][1] -= 30 - bullets[0][0]
				bullets[0][0] += 30 - bullets[0][0]
			else:
				bullets[0][0] += bullets[0][1]
				bullets[0][1] = 0
			animation = current_weapon+"_reload"
			$AnimatedSprite.play(current_weapon+"_reload")
			
		elif(bullets[1][1] > 0):
			$AudioStreamPlayer2D.stream = load("res://character/assets/sounds/gun-cocking-01.wav")
			$AudioStreamPlayer2D.play() 
			if(bullets[1][1] >= 10 - bullets[1][0]):
				bullets[1][1] -= 10 - bullets[1][0]
				bullets[1][0] += 10 - bullets[1][0]
			else:
				bullets[1][0] += bullets[1][1]
				bullets[1][1] = 0
			animation = current_weapon+"_reload"
			$AnimatedSprite.play(current_weapon+"_reload")
	
	if(Input.is_action_pressed("pick")):
		if(is_weapon != null):
			if(is_weapon.item_type=="bullets"):
				if(is_weapon.weapon_name=="handgun_bullets"):
					bullets[1][1] += 10
				else:
					bullets[0][1] += 30
			else:
				weapons_list.append(is_weapon.weapon_name) 
			is_weapon.queue_free()
	
	if(Input.is_action_just_pressed("attack")):
		is_attack = true
		$AudioStreamPlayer2D.stream = load("res://character/assets/sounds/knife_slash7.wav")
		if(current_weapon!="knife"):
			if(bullets[0][0] > 0 and current_weapon=="rifle"):
				$AudioStreamPlayer2D.stream = load("res://character/assets/sounds/gun-gunshot-01.wav")
				bullets[0][0] -= 1
				fire()
			elif(bullets[1][0] > 0 and current_weapon=="handgun"):
				$AudioStreamPlayer2D.stream = load("res://character/assets/sounds/gun-gunshot-02.wav")
				bullets[1][0] -= 1
				fire()
			else:
				$AudioStreamPlayer2D.stream = load("res://character/assets/sounds/gun-trigger-click-01.wav")
		$AudioStreamPlayer2D.play()
		animation = current_weapon+"_attack"
		$AnimatedSprite.play(current_weapon+"_attack")
		#rset_unreliable("slave_position", motion)
	look_at(get_global_mouse_position())
	

func _process(delta):
	is_motion = false
	input()
	rpc("update_loc",get_tree().get_network_unique_id(),motion,get_global_mouse_position(),animation)
	#print(motion)
	$Muzzle/Sprite.hide()
	
	if(health <= 0):
		queue_free()
	if(!is_motion):
		$AudioStreamPlayer2D2.stop()

func _on_AnimatedSprite_animation_finished():
	is_attack = false
	animation = current_weapon+"_idle"
	$AnimatedSprite.play(current_weapon+"_idle")

func fire():
	var shot = bullet.instance()
	$Muzzle.add_child(shot)
	$Muzzle/Sprite.show()
	
remote func update_loc(id,loc,rot,animation):
	#print("aa")
	var enemy = get_node("/root/world/"+str(id)+"/Enemy")
	enemy.move_and_slide(loc,Vector2(0,0))
	enemy.look_at(rot)
	enemy.get_node('AnimatedSprite').play(animation)
