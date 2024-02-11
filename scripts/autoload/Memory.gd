extends Node
var memory: Array[bool] = [false, false, false]

signal memory_change()

func set_memory(new_memory: Array[bool]) -> void:
	memory = new_memory
	
	memory_change.emit()

func get_int() -> int:
	var total = 0
	
	if Memory.memory[0]:
		total += 1
	if Memory.memory[1]:
		total += 2
	if Memory.memory[2]:
		total += 4
		
	return total

func set_int(val: int) -> void:
	val = val % 8
	
	if val >= 4:
		memory[2] = true
		val -= 4
	else:
		memory[0] = false
	
	if val >= 2:
		memory[1] = true
		val -= 1	
	else:
		memory[0] = false	
	
	if val == 1:
		memory[0] = true
	else:
		memory[0] = false
		
	memory_change.emit()
