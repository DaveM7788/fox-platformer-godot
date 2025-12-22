extends Node2D

class_name Shooter

@export var speed: float = 50.0
@export var shoot_delay: float = 0.7
@export var bullet_key: Constants.ObjectType = \
			Constants.ObjectType.BULLET_PLAYER

@onready var timer: Timer = $Timer
@onready var sound: AudioStreamPlayer2D = $Sound

var _can_shoot: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = shoot_delay


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func shoot(direction: Vector2) -> void:
	if !_can_shoot:
		return
	_can_shoot = false
	SignalHub.emit_on_create_bullet(
		global_position, direction, speed, bullet_key
	)
	timer.start()
	sound.play()


func _on_timer_timeout() -> void:
	_can_shoot = true
