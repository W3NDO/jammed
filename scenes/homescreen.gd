extends Control

@onready var routes : Node = $Routes
@export var car_scene : PackedScene
@onready var SceneTransitionAnimation = $SceneTransition/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	draw_car()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		SceneTransitionAnimation.play("fade_in")
		await get_tree().create_timer(0.5).timeout
		get_tree().change_scene_to_file("res://scenes/intro_level.tscn")


func draw_car():
	if routes.get_child_count() == 0:
		print("No routes")

	var new_car = car_scene.instantiate()
	var all_routes =  routes.get_children()
	var route = all_routes[0]

	route.add_child(new_car)
	new_car.progress= 0
