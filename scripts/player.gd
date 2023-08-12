extends CharacterBody2D
class_name Player

@export var gravity = 400
@export var jump_force = 200
@export var speed = 125

@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _physics_process(delta):
	if is_on_floor()==false:
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	
	var direction = 0
	if active==true:
		if Input.is_action_just_pressed("jump"): #&& is_on_floor():
			jump(jump_force)
		
		direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.flip_v = (direction == -1)
	
	velocity.x = direction * speed
	move_and_slide()
	if gravity > 0:
		update_animations(direction)
	
	change_gravity(direction)

func jump(force):
	AudioPlayer.play_sfx("jump")
	velocity.y = -force

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump")
		else:
			animated_sprite.play("fall")
			
			

			
func change_gravity(direction):
	update_animations_no_gravity(direction);
	if Input.is_action_just_pressed("gravity"):
		gravity = gravity*(-1)
		jump_force = jump_force*(-1)


func update_animations_no_gravity(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle_no")
		else:
			animated_sprite.play("run_no")
	else:
		if velocity.y < 0:
			animated_sprite.play("jump_no")
		else:
			animated_sprite.play("fall_no")
		
	


