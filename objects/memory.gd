extends Node2D

@export_category("Sprites")
@export var false_sprite: Texture2D
@export var true_sprite: Texture2D

@onready var lights: Array[Sprite2D] = [$Bit1, $Bit2, $Bit3]

func _ready():
	Memory.memory_change.connect(_on_memory_change)

func _on_memory_change():
	update_lights()

func update_lights():
	for i in range(3):
		if Memory.memory[i]:
			lights[i].texture = true_sprite
		else:
			lights[i].texture = false_sprite
