extends Node2D
var selfPeerID
var player_info = []
var my_info = {id = 1 , name = "" ,loc = Vector2(rand_range(10,1000),rand_range(10,1000))}
var player
func _ready():
	get_tree().connect("connected_to_server", self, "_connected_ok")
	$ServerPort.text = "9000"
	$ClientPort.text = "9000"
	$Ip.text = "127.0.0.1"

func _process(delta):
	#print_tree_pretty()
	my_info["name"] = $Name.text
	$PlayersConnected.text = ""
	for player in player_info:
		$PlayersConnected.text += player["name"]+"\n"

func _on_CreateLobby_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(int($ServerPort.text), 5)
	get_tree().set_network_peer(peer)

func _on_JoinLobby_pressed():
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client($Ip.text, int($ClientPort.text))
	get_tree().set_network_peer(peer)

func _connected_ok():
	my_info["id"] =  get_tree().get_network_unique_id()
	#print(my_info)
	rpc("register_player", get_tree().get_network_unique_id(), my_info)
	
remote func register_player(id, info):
	if get_tree().is_network_server():
		rpc_id(id, "register_player",1, my_info)
		for player in player_info:
			rpc_id(id, "register_player", player["id"], player)
			rpc_id(player["id"],"register_player",id,info)
	player_info.append(info)
	print(player)
func _on_Start_pressed():
	for player in player_info:
		rpc_id(player["id"],"scene_initialize")
	scene_initialize()

remote func scene_initialize():
	var map_res = load('res://Node2D.tscn')
	var map = map_res.instance()
	get_parent().add_child(map)
	var player_res = load('res://character/player/Player.tscn')
	var enemy_res = load('res://character/enemy/enemy.tscn')
	for player in player_info:
		var enemy =  enemy_res.instance()
		enemy.position = player["loc"]
		enemy.set_name(str(player["id"]))
		get_parent().get_node('world').add_child(enemy)
	var player = player_res.instance()
	player.position = my_info["loc"]
	get_parent().get_node('world').add_child(player)