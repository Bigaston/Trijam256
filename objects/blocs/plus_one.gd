extends Bloc

func action():
	Memory.set_int(Memory.get_int() + 1)
