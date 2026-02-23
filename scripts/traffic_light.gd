extends Area2D

var is_green: bool = false
@export var green_texture: Texture2D
@export var red_texture: Texture2D
@onready var collision_shape: CollisionShape2D = $StaticBody2D/CollisionShape_input
@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite_2: Sprite2D = $Sprite2D2
@onready var collision_shape_stop: CollisionShape2D = $CollisionShapeStop
@onready var point_light_2d: PointLight2D = $PointLight2D


func _ready():
	update_visuals()
	
func toggle_light():
	is_green = !is_green
	var tween = create_tween()
	tween.tween_property(sprite, "scale", Vector2(1.2, 1.2), 0.05)
	tween.tween_property(sprite, "scale", Vector2(1.0, 1.0), 0.05)
	collision_shape_stop.set_deferred("disabled", is_green)
	update_visuals()
	print("IS NOW: " +  "green" if is_green else "red")
	
func update_visuals():
		sprite.texture = green_texture if is_green else red_texture
		sprite_2.texture = green_texture if is_green else red_texture
		point_light_2d.color= "#2ECC71" if is_green else "#E74C3C"

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	print("Input noted")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		#toggle_light()
		pass


func _on_static_body_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	print("Input noted")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		toggle_light()
