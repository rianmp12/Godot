extends Area2D

var speed = 400
var screen_size

signal hit

func _ready():
	hide()
	screen_size = get_viewport_rect().size
	
	

func _process(delta:float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
		$rastro.emitting = true
	else:
		$AnimatedSprite.stop()
		$rastro.emitting = false
	position += velocity * delta
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "direita"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	if velocity.y != 0:
		$AnimatedSprite.animation = "cima"
		$AnimatedSprite.flip_v = velocity.y > 0
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_jogador_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
