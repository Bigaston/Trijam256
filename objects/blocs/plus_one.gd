extends Bloc

func action():
	print(Memory.get_int())
	Memory.set_int(Memory.get_int() + 1)
