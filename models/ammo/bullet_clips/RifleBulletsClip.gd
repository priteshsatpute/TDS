extends Area2D

var weapon_name = "rifle_bullets"
var item_type = "bullets"
var selfPeerID
func _ready():
	selfPeerID = get_tree().get_network_unique_id()
func _on_Rifle_body_entered(body):
	$RichTextLabel.text = "7.86mm Bullets[30]  [Press F]"
	var player = get_node("/root/world/"+str(selfPeerID)+"/Player")
	player.is_weapon = self


func _on_Rifle_body_exited(body):
	var player = get_node("/root/world/"+selfPeerID+"/Player")
	player.is_weapon = null
	$RichTextLabel.text = ""
