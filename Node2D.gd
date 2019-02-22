extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var selfPeerID = ""
var msg = ""
var cursor = load("res://common_assets/images/Webp.net-resizeimage.png")
func _ready():
	selfPeerID = get_tree().get_network_unique_id()
	# Called when the node is added to the scene for the first time.
	# Initialization here
	Input.set_custom_mouse_cursor(cursor)
	pass

func _process(delta):
	#print_tree_pretty()
	#var player = get_tree().get_root().get_node("world/Node2D/Player")
	#if(player == null):
	#	msg = "Ab royega kya?!"
	#else:
	#	if(player.weapons_list.find("handgun")>=0):
	#		msg += " 		Pistol :"+str(player.bullets[1][0])+"/"+str(player.bullets[1][1]) 
	#	if(player.weapons_list.find("rifle")>=0):
	#		msg += "		Rifle :"+str(player.bullets[0][0])+"/"+str(player.bullets[0][1]) 
	pass