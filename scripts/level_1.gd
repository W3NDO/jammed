extends Node2D

# load car scenes
@export var cars: Array[PackedScene] = []
@onready var routes: Node2D = $Routes

func _on_car_spawn_timer_timeout() -> void:
	spawn_random_car_on_random_route()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func spawn_random_car_on_random_route():
	var car_path_index = randi() % 4
	if cars.size() == 0 or routes.get_child_count() == 0:
		print("Missing car scenes or routes!")
		return

	# 1. Pick a random car type
	var selected_car_scene = cars[car_path_index]

	# 2. Pick a random route
	var all_paths = routes.get_children()
	var selected_path = all_paths[car_path_index]

	# 3. Instantiate and attach
	var new_car = selected_car_scene.instantiate()
	selected_path.add_child(new_car)
	new_car.progress = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
