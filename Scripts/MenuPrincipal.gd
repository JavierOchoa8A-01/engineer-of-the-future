extends CanvasLayer

func _ready():
	# Conectamos las señales de los botones por código
	# Asegúrate de que los nombres de los nodos coincidan
	$VBoxContainer/ButtonJugar.pressed.connect(_on_jugar_pressed)
	$VBoxContainer/ButtonSalir.pressed.connect(_on_salir_pressed)

func _on_jugar_pressed():
	# Cambia a la escena del juego (Mundo)
	get_tree().change_scene_to_file("res://Scenes/mundo.tscn")

func _on_salir_pressed():
	# Cierra el juego
	get_tree().quit()
