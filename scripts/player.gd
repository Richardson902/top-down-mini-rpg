extends CharacterBody2D


const speed = 100 # Sets default speed
var current_dir = "none" # To keep track of direction for anims
var sprites = [] # Array of our Sprite2D Nodes

# Populate the array with each Sprite 2D Node in our player Node
func _ready():
	sprites.append($Skeleton/Body)
	sprites.append($Skeleton/Head)
	sprites.append($Skeleton/Hair)
	sprites.append($Skeleton/Shirt)
	sprites.append($Skeleton/Pants)
	sprites.append($Skeleton/Shoes)

# Calls playermovement on physics process
func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	if Input.is_action_pressed("right"):
		current_dir = "right" # Sets the current direction based on direction we are moving
		play_animation(1) # Play animation and passes through 1 which means moving (ugly way to do it but I'm running out of time)
		velocity.x = speed # Sets speed to right direction (positive x)
		velocity.y = 0 # Sets up and down movement to zero (makes it so you can't move two directions at once ffs have to fix)
	elif Input.is_action_pressed("left"):
		current_dir = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("down"):
		current_dir = "down"
		play_animation(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("up"):
		current_dir = "up"
		play_animation(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_animation(0) # If not moving call this and pass 0 to play idle animation
		velocity.x = 0 # Set velocity to 0 because we are not moving
		velocity.y = 0
		
	move_and_slide() # Yippee

func play_animation(movement): # Handles the playing of animations
	var direction = current_dir
	var animation_player = $AnimationPlayer # Our Animation Player Node
	
	if direction == "right":
		flip_player(false) # Don't flip H if we going right
		if movement == 1: # If moving play the walk anim
			animation_player.play("walk_side")
		elif movement == 0: # If not moving play the idle anim
			animation_player.play("idle_side")
	elif direction == "left":
		flip_player(true)
		if movement == 1:
			animation_player.play("walk_side")
		elif movement == 0:
			animation_player.play("idle_side")
	elif direction == "up":
		if movement == 1:
			animation_player.play("walk_back")
		elif movement == 0:
			animation_player.play("idle_back")
	elif direction == "down":
		if movement == 1:
			animation_player.play("walk_front")
		elif movement == 0:
			animation_player.play("idle_front")
			
func flip_player(flip: bool): # Flips the sprites in the array
	for sprite in sprites:
		sprite.flip_h = flip
		
