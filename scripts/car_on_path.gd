extends PathFollow2D

@export var speed: float = 150.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var ray_front: RayCast2D = $ray_front
@export var detection_range: float = 50.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ray_front.target_position = Vector2(detection_range, 0)
	sprite.rotation_degrees = 90.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_front.is_colliding():
		# print("collision" + str(ray_front.get_collision_point()))
		return
	
	progress += speed * delta
	
	if progress_ratio >= 1.0:
		queue_free()
	
