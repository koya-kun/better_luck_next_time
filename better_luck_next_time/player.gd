extends CharacterBody2D

#movement
var SPEED: float = 400
var JUMP_HEIGHT: float = -800
var GRAVITY: float = 40   
var JUMP_BUFFER: float = 0.2
var COYOTE_TIME: float = 0.3
var WALLJUMP_HEIGHT: float = 500
var WALLJUMP_TIME: float = 0.2
var WALLJUMP_BACKLASH: float = 100
var coyote_count: float = 0
var jump_buffer_count: float = -1
var gravity_mod: float
var look_direction: float = 1
var walljump_count: float = 0
var moveable: bool = true

var OG_SIZE: Vector2

func _ready() -> void:
	OG_SIZE = $ColorRect.size
	gravity_mod = GRAVITY

func _process(delta: float) -> void:
	if Input.is_action_pressed("left") and moveable:
		position.x -= SPEED * delta
		look_direction = -1
	if Input.is_action_pressed("right") and moveable:
		position.x += SPEED * delta
		look_direction = 1
	# jump
	if jump_buffer_count > 0 and coyote_count >= 0:
		velocity.y = JUMP_HEIGHT
		jump_buffer_count = 0
	if jump_buffer_count >= 0:
		jump_buffer_count -= delta
	if walljump_count >= 0:
		walljump_count -= delta
	if is_on_floor():
		coyote_count = COYOTE_TIME
	else:
		velocity.y += gravity_mod
		coyote_count -= delta
	if is_on_wall() and jump_buffer_count > 0:
		velocity.y -= WALLJUMP_HEIGHT
		walljump_count = WALLJUMP_TIME
		velocity.x -= look_direction * WALLJUMP_BACKLASH
	elif walljump_count <= 0.05 and walljump_count > 0:
		velocity.x = 0
		walljump_count = 0
	if walljump_count > 0:
		moveable = false
	else:
		moveable = true
	move_and_slide()
	squish_squash()
	

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		jump_buffer_count = JUMP_BUFFER
		
	if Input.is_action_just_released("jump"):
		if velocity.y < 0:
			velocity.y =  0

func squish_squash() -> void:
	if abs(velocity.y) >= 300:
		$ColorRect.size.x = OG_SIZE.x * 0.8
		$ColorRect.size.y =  OG_SIZE.y * 1.2
	else:
		$ColorRect.size = OG_SIZE
