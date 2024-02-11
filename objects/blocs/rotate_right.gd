extends Bloc

func action():
	var local_mem = Memory.memory
	var mem0 = local_mem[0]
	
	local_mem[0] = local_mem[1]
	local_mem[1] = local_mem[2]
	local_mem[2] = mem0
	
	Memory.set_memory(local_mem)
