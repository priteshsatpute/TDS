extends Node2D
var player
func _ready():
	player = get_parent().get_parent()
	$HandgunBulletsTextureProgress.visible = false
	$RifleBulletsTextureProgress.visible = false
	pass

func _process(delta):
	$Health.text = "Health :"+str(player.health)
	$HealthTextureProgress.value = player.health

	if(player.weapons_list.find("handgun")>=0):
			$HandgunBullets.text = "Pistol :"+str(player.bullets[1][0])+"/"+str(player.bullets[1][1])
			$HandgunBulletsTextureProgress.value = player.bullets[1][0]
			$HandgunBulletsTextureProgress.visible = true
	if(player.weapons_list.find("rifle")>=0):
			$RifleBulletsTextureProgress.value = player.bullets[0][0]
			$RifleBullets.text = "Rifle :"+str(player.bullets[0][0])+"/"+str(player.bullets[0][1])
			$RifleBulletsTextureProgress.visible = true