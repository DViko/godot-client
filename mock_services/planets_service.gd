extends Node

func get_planet_data(data: Array[String]) -> Dictionary[String, String]:
	await get_tree().create_timer(8.0).timeout
	return {
		"id": "1234e-5463j",
		"planet_name": "Aresa",
		"planet_type": "Ледяная",
		"temp_min": "-180",
		"temp_max": "-90",
		"home": "true",
	}
