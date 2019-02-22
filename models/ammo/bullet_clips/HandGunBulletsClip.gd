extends Area2D

var weapon_name = "handgun_bullets"
var item_type = "bullets"
var selfPeerID
func _ready():
	selfPeerID = get_tree().get_network_unique_id()
func _on_Rifle_body_entered(body):
	$RichTextLabel.text = "3mm Bullets[10]  [Press F]"
	var player = get_parent().get_node("world/Player")
	player.is_weapon = self


func _on_Rifle_body_exited(body):
	var player = get_parent().get_node("world/Player")
	player.is_weapon = null
	$RichTextLabel.text = ""
