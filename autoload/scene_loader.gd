extends Node

var scenes: Array[String] = [
	"res://scenes/main_container.tscn"
]

enum {
	INVALID = 0,
	LOADING = 1,
	FAILED = 2,
	LOADED = 3,
}

func initialize() -> void:
	await load_async(scenes[0])

func load_async(path: String):
	if ResourceLoader.load_threaded_request(path) != OK:
		push_error("Loading error: threaded_request")
		return
		
	while ResourceLoader.load_threaded_get_status(path) == LOADING:
		await Engine.get_main_loop().process_frame
		
		var status = ResourceLoader.load_threaded_get_status(path)
		
		match status:
			INVALID:
				push_error("Invalid file path")
			LOADED:
				var scene = ResourceLoader.load_threaded_get(path).instantiate()
				scene.initialize_data({ "player_name": "TestUser" })
				get_tree().current_scene.add_child(scene)
			FAILED:
				push_error("Failed to load scene")
				
#Итак ResourceLoader.load_threaded_request(path) выдает ок но 
#ResourceLoader.load_threaded_get_status(path) после LOADING выдает FAILED. Гдн может быть засада ?
