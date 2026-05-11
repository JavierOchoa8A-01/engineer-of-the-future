# res://Scripts/GameController.gd
extends Node

@onready var model = $JugadorDomain
@onready var view = $HUD
@onready var iki_visual = $IkiVisual # El CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	model.stats_changed.connect(view.update_hud)

func _physics_process(delta):
	# Aplicar gravedad a la Vista
	if not iki_visual.is_on_floor():
		iki_visual.velocity += iki_visual.get_gravity() * delta

	# Manejar Salto (Caso de Uso: Saltar)
	if Input.is_action_just_pressed("ui_accept") and iki_visual.is_on_floor():
		iki_visual.velocity.y = JUMP_VELOCITY

	# Manejar Movimiento (A / D)
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		iki_visual.velocity.x = direction * SPEED
	else:
		iki_visual.velocity.x = move_toward(iki_visual.velocity.x, 0, SPEED)

	iki_visual.move_and_slide()


func _on_mnemonico_body_entered(body: Node2D) -> void:
	if body.name == "IkiVisual":
		model.recolectar_mnemonico() # Le avisamos al modelo
		print("Mnemónico obtenido")
