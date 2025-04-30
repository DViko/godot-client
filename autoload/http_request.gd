extends HTTPRequest

#request signals
signal get_request(type: int, data: Array[String], init_by: Node);
signal post_request(type: int, data: Array[String], init_by: Node);

var headers: Array[String];
var url: String;
var body: Dictionary = {};
var init_node: Node;
var process: bool = false;

func _ready() -> void:
	get_request.connect(get_handler);
	post_request.connect(post_handler);

func get_handler(type, data, init_by):
	init_node = init_by;
	self.request_completed.connect(http_get);
	self.request("http://localhost:8080/authentication/login");
	
func post_handler(type, data, init_by):
	if process != false:
		pass;
	else:
		process = true;
		init_node = init_by;
		
	match type:
		0:
			headers = ["Content-Type: application/json"];
			url = "https://localhost:8080/v1/authentication/signin";
			body = {
				"email": data[0],
				"password": data[1]
			};
			
	self.request_completed.connect(http_post);
	self.request(url, headers, HTTPClient.METHOD_POST, JSON.stringify(body));

func http_get(result, response, headers, body):
	init_node.response(JSON.parse_string(body.get_string_from_utf8()));
	

func http_post(result, response, headers, body):
	init_node.response(JSON.parse_string(body.get_string_from_utf8()));
	process = false;
