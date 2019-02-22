extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var teamp = false
var health = 100
var selfPeerID
func _ready():
	selfPeerID = get_tree().get_network_unique_id()

func _process(delta):
	var player = get_node("/root/world/"+str(selfPeerID)+"/Player")
	if(health<=0):
		queue_free()
	if(teamp):
		player.health -= 1
	#print(teamp)

func _on_Area2D_body_exited(body):
	#if(body.Player.entity == "player"):
	teamp = false

func _on_Area2D_body_entered(body):
	#if(body.Player.entity == "player"):
	teamp = true
	print(teamp)


	
	
