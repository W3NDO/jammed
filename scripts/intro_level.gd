extends Node2D

@onready var routes: Node2D = $Routes
@export var cars: Array[PackedScene] = []
@onready var score: Label = $Score
@onready var SceneTransitionAnimation : AnimationPlayer = $SceneTransition/AnimationPlayer
@onready var LevelTimer: Timer = $LevelTimer
@export var TimeLeft: int = 90

var level_score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SceneTransitionAnimation.get_parent().get_node("ColorRect").color.a = 255
	SceneTransitionAnimation.play("fade_out")
	await get_tree().create_timer(0.5).timeout
	LevelTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func spawn_random_car_on_random_route():
	var car_path_index = randi() % 2
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


func _on_car_spawn_timer_timeout() -> void:
	var spawn = [0,1].pick_random()
	if spawn == 0:
		spawn_random_car_on_random_route()
	else:
		pass

func _on_goal_line_area_entered(area: Area2D) -> void:
	tally_score(area)


func _on_goal_line_2_area_entered(area: Area2D) -> void:
	tally_score(area)

func tally_score(area: Area2D):
	if area.get_parent().is_in_group("cars"):
		print("car noted")
		level_score += 1
		score.text = "YOUR SCORE " + str(level_score) + " TIME LEFT: " + str(TimeLeft)
	else:
		print("not in cars group")


func _on_level_timer_timeout() -> void:
	TimeLeft -= 1
	print(TimeLeft)
	if TimeLeft <= 0:
		print("Countdown finished")
	else:
		LevelTimer.start()
