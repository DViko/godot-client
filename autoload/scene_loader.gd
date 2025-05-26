extends Node

var scenes: Array[String] = [
	"res://scenes/main_container.tscn"
]

var loaders: Array[String] = [
	"res://scenes/loder.tscn"
]

enum {
	INVALID = 0,
	LOADING = 1,
	FAILED = 2,
	LOADED = 3,
}

func initialize() -> void:
	await load_async(loaders[0])
	HttpManager.connect("http_request_completed", prepare)
	HttpManager.emit_signal("http_request", 1, [""])
	
	
func prepare(flag: bool) -> void:
	print("prepare")
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
				var current = get_tree().current_scene
				
				if current:
					current.queue_free()
					
				get_tree().root.add_child(scene)
				get_tree().current_scene = scene
			FAILED:
				push_error("Failed to load scene")
			
