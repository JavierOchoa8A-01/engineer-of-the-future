extends CanvasLayer
class_name GameView

@onready var health_bar = $ProgressBar # Asegúrate que el nombre coincida

func update_hud(h, e, m):
	health_bar.value = h
	# Aquí podrías actualizar etiquetas de texto para energía o mnemónicos
