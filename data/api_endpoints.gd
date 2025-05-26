class_name ApiEndpoints
extends RefCounted

var authentication: Array[String] = [
	"https://localhost:8080/v1/authentication/signin"
]

var planets : Array[String] = [
	"https://localhost:8080/v1/planets"
]

func get_construct() -> Array:
	return [
		planets[0],
		[
			"Accept: application/json"
			##"Authorization: Bearer %s", UserSync.get_token()
		],
		HTTPClient.METHOD_GET
	]
	
func post_construct(data) -> Array:
	return [
			authentication[0],
		[
			"Content-Type: application/json",
			##"Authorization: Bearer %s", UserSync.get_token()
		],
		HTTPClient.METHOD_POST,
		{
			"email": data[0],
			"password": data[1]
		}
	]
