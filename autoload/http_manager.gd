extends HTTPRequest

#request signals
signal http_request(type: int, data: Array[String])

signal http_request_completed(flag: bool)

@onready var endpoints: ApiEndpoints = ApiEndpoints.new()

var is_processing: bool = false

func _ready() -> void:
	http_request.connect(request_handler)

func request_handler(type, data):
	if is_processing:
		return
	
	is_processing = true
	
	match type:
		0:
			var result = await AuthService.auth_user([])
			UserSync.set_user_payload(result)
			emit_signal("http_request_completed", true)
			is_processing = false
		1:
			var result = await PlanetsService.get_planet_data([])
			UserSync.set_planets_data(result)
			emit_signal("http_request_completed", true)
			is_processing = false
	
	
	##var request = []
	
	#match type:
		#0: 
			#request = endpoints.post_construct(data)
			#var status = self.request(request[0], request[1], request[2], JSON.stringify(request[3]))
			#if status != OK:
				#print("Connect error")
			#else:
				#var result = await self.request_completed
				#UserSync.set_user_payload(JSON.parse_string(result[3].get_string_from_utf8()))
				#emit_signal("http_request_completed", true)
				#is_processing = false
		#1:
			#request = endpoints.get_construct()
			#var status = self.request(request[0], request[1], request[2])
			#if status != OK:
				#print("Connect error")
			#else:
				#var result = await self.request_completed
				#UserSync.set_planets_data(JSON.parse_string(result[3].get_string_from_utf8()))
				#emit_signal("http_request_completed", true)
				#is_processing = false
		#_:
			#push_error("Unknown request type")
			#return
