extends CharacterBody2D


@export var speed: float = 100
@export var acceleration: float = 100
var animated_sprite: AnimatedSprite2D

func _ready() -> void:
	animated_sprite = $AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	# Get the input direction: -1, 0, 1
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down") # inputs based on project settings keybinds
	
	# Apply movement
	velocity.x = move_toward(velocity.x, speed * direction.x, acceleration)
	velocity.y = move_toward(velocity.y, speed * direction.y, acceleration)
	
	
	move_and_slide()
	
	# Change animation based on which direction bro is moving
	if direction != Vector2.ZERO:
		if direction.x < 0:
			animated_sprite.play("walk left")
		elif direction.x > 0:
			animated_sprite.play("walk right")
		elif direction.y < 0:
			animated_sprite.play("walk backward")
		elif direction.y > 0:
			animated_sprite.play("walk forward")
	else:
		animated_sprite.stop() # Stop animation if not moving - no idle anim so this is fine atm
