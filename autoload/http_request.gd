extends HTTPRequest

#request signals
signal get_request(type: int, data: Array[String], init_by: Node)
signal post_request(type: int, data: Array[String], init_by: Node)

@onready var http_dict: HttpRef = HttpRef.new()

func _ready() -> void:
	get_request.connect(get_handler)
	post_request.connect(post_handler)
	
func process_toggler(flag, node) -> void:
	match flag:
		true:
			http_dict.process = true
			http_dict.init_node = node
		false:
			http_dict.process = false
			http_dict.init_node = node

func get_handler(type, data, init_by):
	if http_dict.process != false:
		pass
	else:
		process_toggler(true, init_by)
		
	match type:
		0: pass
			
	self.request_completed.connect(http_get)
	self.request("http://localhost:8080/authentication/login")

func post_handler(type, data, init_by):
	if http_dict.process != false:
		pass
	else:
		process_toggler(true, init_by)
		
	match type:
		0:
			http_dict.headers = ["Content-Type: application/json"]
			http_dict.url = "https://localhost:8080/v1/authentication/signin"
			http_dict.body = {
				"email": data[0],
				"password": data[1]
			}
			
	self.request_completed.connect(http_post)
	self.request(http_dict.url, http_dict.headers, HTTPClient.METHOD_POST, JSON.stringify(http_dict.body))

func http_get(result, response, headers, body):
	http_dict.init_node.response(JSON.parse_string(body.get_string_from_utf8()))
	process_toggler(false, null)

func http_post(result, response, headers, body):
	http_dict.init_node.response(JSON.parse_string(body.get_string_from_utf8()))
	process_toggler(false, null)
