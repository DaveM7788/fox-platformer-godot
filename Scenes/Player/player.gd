extends CharacterBody2D

class_name Player

@onready var sprite_2d: Sprite2D = $Sprite2D

const GRAVITY: float = 690.0
const JUMP_SPEED: float = -270.0
const RUN_SPEED: float = 200.0

# animations are handled in the animation tree. click a transition. 
# expression box under Advance. contains code

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y += GRAVITY * delta
	
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		velocity.y = JUMP_SPEED
	
	velocity.x = RUN_SPEED * Input.get_axis("left", "right")
	if !is_equal_approx(velocity.x, 0.0):
		sprite_2d.flip_h = velocity.x < 0
	
	move_and_slide()
