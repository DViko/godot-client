extends Node

var payload: Dictionary[String, String]

var structures: Dictionary[String, BuildingRef]
var planets: Dictionary[String, String]


func set_user_payload(data: Dictionary[String,String]) -> void:
	payload = data
	
func set_planets_data(data: Dictionary[String, String]) -> void:
	planets = data
	
func get_user_name() -> String:
	return "Painkiller"
	
func get_token() -> String:
	return ""
