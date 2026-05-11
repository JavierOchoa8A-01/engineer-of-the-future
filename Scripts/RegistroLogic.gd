extends Node
class_name RegistroLogic

var valor: int = 0
signal overflow_detected
signal zero_detected(success)

func aplicar_instruccion(v):
	valor += v
	if valor > 255: overflow_detected.emit()
	if valor == 0: zero_detected.emit(true)
