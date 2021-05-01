extends KinematicBody

onready var Camera = $Pivot/Cameraz
onready var Explosion = load("res://Explosion/Explosion.tscn")
onready var Explosions = get_node("/root/Game/Explosions")

var gravity = -30
var max_speed = 8
var mouse_sensitivity = 0.002
var mouse_range = 1.2

var velocity = Vector3()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(event.relative.y * mouse_sensitivity)
		rotate_y(-event.relative.x * mouse_sensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouse_range, mouse_range)

func _physics_process(_delta):
	if Input.is_action_just_pressed("shoot"):
		if $Pivot/RayCast.is_colliding():
			var target = $Pivot/RayCast.get_collider()
			if target.is_in_group("target"):
				var explosion = Explosion.instance()
				Explosions.add_child(explosion)
				explosion.global_transform.origin = $Pivot/RayCast.get_collision_point()
				target.die()
