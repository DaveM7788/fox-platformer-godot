extends CharacterBody2D

class_name Player

@export var fall_y_bound: float = 700.0

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var debug_label: Label = $DebugLabel

const GRAVITY: float = 690.0
const JUMP_SPEED: float = -400.0
const RUN_SPEED: float = 150.0
const MAX_FALL: float = 350.0

# animations are handled in the animation tree. click a transition. 
# expression box under Advance. contains code

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _enter_tree() -> void:
	add_to_group(Constants.PLAYER_GROUP)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_SPEED
	
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if !is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0
	
	velocity.y = clampf(velocity.y, JUMP_SPEED, MAX_FALL)
	
	y_bound_fall_check()
	move_and_slide()
	update_debug_label()

func update_debug_label() -> void:
	var ds: String = ""
	ds += "floor: %s \n" % [is_on_floor()]
	ds += "p: %.1f %.1f \n" % [global_position.x, global_position.y]
	ds += "v: %.1f %.1f" % [velocity.x, velocity.y]
	debug_label.text = ds

func y_bound_fall_check() -> void:
	if global_position.y > fall_y_bound:
		queue_free()
