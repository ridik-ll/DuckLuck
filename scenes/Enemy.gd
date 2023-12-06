extends CharacterBody2D


var speed = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var main_character
var chase = false

func _physics_process(delta):
	velocity.y += gravity * delta
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "hit":
			get_node("AnimatedSprite2D").play("run")
		main_character = get_node("../../main_character/main_character")
		var direction = (main_character.global_position - self.global_position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true
		velocity.x = direction.x * speed
		
	else:
		velocity.x = 0
		if get_node("AnimatedSprite2D").animation != "hit":
			get_node("AnimatedSprite2D").play("default")
	
	move_and_slide()


func _on_player_detection_body_entered(body):
	if body.name == "main_character":
		chase = true
		


func _on_player_detection_body_exited(body):
	if body.name == "main_character":
		chase = false


func _on_player_kill_body_entered(body):
	if body.name == "main_character":
		death()





func _on_player_collision_body_entered(body):
	if body.name == "main_character":
		Game.Player_HP -= 3
		death()
		
		
func death():
	Game.gold += 1
	Utils.saveGame()
	chase = false
	get_node("AnimatedSprite2D").play("hit")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
