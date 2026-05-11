extends Node
class_name JugadorDomain

var health: int = 100
var energy: int = 100
var mnemonicos: int = 0

signal stats_changed(h, e, m)

func modificar_salud(cantidad: int):
	health = clamp(health + cantidad, 0, 100)
	stats_changed.emit(health, energy, mnemonicos)

func recolectar_mnemonico():
	mnemonicos += 1
	# Al recolectar, consumimos un poco de energía según el GDD
	energy = clamp(energy - 2, 0, 100) 
	stats_changed.emit(health, energy, mnemonicos)
