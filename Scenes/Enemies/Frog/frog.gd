extends EnemyBase

var _seen_player: bool = false
var _can_jump: bool = false

const JUMP_VELOCITY_RIGHT = Vector2(100, -150)
const JUMP_VELOCITY_LEFT = Vector2(-100, -150)

@onready var jump_timer: Timer = $JumpTimer

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	velocity.y += delta * _gravity

	apply_jump()
	move_and_slide()
	flip_me()

	if is_on_floor():
		velocity.x = 0.0
		animated_sprite_2d.play("idle")


func apply_jump() -> void:
	if !is_on_floor() || !_can_jump || !_seen_player:
		return

	velocity = JUMP_VELOCITY_RIGHT if animated_sprite_2d.flip_h \
	else JUMP_VELOCITY_LEFT

	_can_jump = false
	start_timer()
	animated_sprite_2d.play("jump")


func start_timer() -> void:
	jump_timer.wait_time = randf_range(2.0, 4.0)
	jump_timer.start()


func _on_jump_timer_timeout() -> void:
	_can_jump = true
	# print("frog can jump setting to true")


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if !_seen_player:
		_seen_player = true
		start_timer()
		# print("frog has seen player")
