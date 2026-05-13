# res://Scripts/GameController.gd
extends Node

@onready var model = $JugadorDomain
@onready var view = $HUD
@onready var iki_visual = $IkiVisual # El CharacterBody2D

const SPEED = 350.0
const JUMP_VELOCITY = -450.0
const ACCELERATION = 1000.0 # Para que no arranque en seco

func _ready():
	model.stats_changed.connect(view.update_hud)

func _physics_process(delta):
	if not iki_visual: return # Seguridad por si el nodo no carga
	
	# 1. Aplicar Gravedad
	if not iki_visual.is_on_floor():
		iki_visual.velocity += iki_visual.get_gravity() * delta

	# 2. Manejar Salto
	if Input.is_action_just_pressed("saltar") and iki_visual.is_on_floor():
		iki_visual.velocity.y = JUMP_VELOCITY

	# 3. Movimiento Horizontal (A/D)
	# Busca esta parte en tu función _physics_process:

	var direction = Input.get_axis("izquierda", "derecha")
	if direction:
		iki_visual.velocity.x = move_toward(iki_visual.velocity.x, direction * SPEED, ACCELERATION * delta)
		
		# USAMOS UNA REFERENCIA SEGURA:
		var sprite = iki_visual.get_node_or_null("Sprite2D")
		if sprite:
			sprite.flip_h = (direction < 0)
	else:
		iki_visual.velocity.x = move_toward(iki_visual.velocity.x, 0, ACCELERATION * delta)
		
	# 4. Ejecutar movimiento
	iki_visual.move_and_slide()


func _on_mnemonico_body_entered(body: Node2D) -> void:
	if body.name == "IkiVisual":
		model.recolectar_mnemonico() # Le avisamos al modelo
		print("Mnemónico obtenido")

func _input(event):
	if event.is_action_pressed("interactuar"):
		# Aquí buscaremos si hay algo cerca para activar
		print("Iki intenta interactuar...")
		_intentar_interaccion()

func _intentar_interaccion():
	# Por ahora, simularemos que interactuar con el aire nos da energía
	# En el futuro, aquí chequearemos colisiones con consolas ENIAC
	model.update_health(5)
