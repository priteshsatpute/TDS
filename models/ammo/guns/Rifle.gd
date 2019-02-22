extends Area2D

var weapon_name = "rifle"
var item_type = "gun"
var selfPeerID
func _ready():
	selfPeerID = get_tree().get_network_unique_id()
func _on_Rifle_body_entered(body):
	$RichTextLabel.text = "Rifle [Press F]"
	var player = get_tree().get_root().get_node("world/Node2D/Player")
	
	player.is_weapon = self


func _on_Rifle_body_exited(body):
	var player = get_tree().get_root().get_node("world/Node2D/Player")
	player.is_weapon = null
	$RichTextLabel.text = ""
