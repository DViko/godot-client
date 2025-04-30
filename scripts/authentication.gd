extends Node

@onready var labels: Array[Node] = [
	$email,
	$password
];

@onready var buttons: Array[Node] = [
	$create,
	$recovery,
	$send
];

func buttons_toggler(flag: bool) -> void:
	for x in range(buttons.size()):
		buttons[x].set_deferred("disabled", flag);
	

func _on_pressed(id :int) -> void:
	match id :
		0: redirect_to_create();
		1: redirect_to_recovery();
		2: http_request();
		
func redirect_to_create() -> void:
	OS.shell_open("https://localhost:8081/signup")
	
func redirect_to_recovery() -> void:
	pass;
	
func http_request() -> void:
	buttons_toggler(true);
	HttpRequest.emit_signal("post_request", 0, [labels[0].text, labels[1].text], self);

func response(data) -> void:
	print(data);
	buttons_toggler(false);
