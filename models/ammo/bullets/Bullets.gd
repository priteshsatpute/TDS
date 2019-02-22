extends Area2D
var SPEED = 12000
var motion = 0
var item_type = "bullets"
var selfPeerID
func _ready():
	selfPeerID = get_tree().get_network_unique_id()
	connect('body_entered', self, '_on_body_entered')
	motion = Vector2(cos(self.rotation), sin(self.rotation)) * SPEED
	#motion = get_global_mouse_position()
func _process(delta):
	position += motion * delta
	#print(motion)
func _on_body_entered(body):
	#print(body.get_node("Enemy"))
	print('bullet just hit: ', body.name)
	#body.get_node("Player").health -=30 
	queue_free()
	