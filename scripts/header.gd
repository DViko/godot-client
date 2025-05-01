extends Node

@onready var link_buttons: Array[Node] = get_tree().get_nodes_in_group("header_links")

var temp_buttom: Node = null

func _ready() -> void:
	link_buttons[0].disabled = true
	temp_buttom = link_buttons[0]
	
func buttons_toggler(node: Node) -> void:
	node.disabled = true
	temp_buttom.disabled = false
	temp_buttom = node

func _on_link_pressed(extra: int) -> void:
	buttons_toggler(link_buttons[extra])
