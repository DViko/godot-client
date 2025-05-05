extends Node

@onready var labels: Array[Node] = [
	$header/Control/user_name
]

func initialize_data(data) -> void:
	labels[0].text = data.player_name
