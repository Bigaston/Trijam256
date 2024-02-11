extends Node2D

var mode: Enum.BottomMode = Enum.BottomMode.None

signal set_bloc(bloc: PackedScene)

# Mode Add
var selected_bloc = 0
var blocs: Array[PackedScene] = [
	preload("res://objects/blocs/plus_one.tscn"),
	preload("res://objects/blocs/minus_one.tscn"),
	preload("res://objects/blocs/rotate_left.tscn"),
	preload("res://objects/blocs/rotate_right.tscn"),
	preload("res://objects/blocs/output.tscn")
]

func _ready() -> void:
	%AddMode.visible = false

func _process(delta: float) -> void:
	if mode == Enum.BottomMode.Add:
		if Input.is_action_just_pressed("ui_right"):
			selected_bloc += 1
			
			if selected_bloc > blocs.size() -1:
				selected_bloc = 0
				
			update_bloc_selector_pos()
			
		if Input.is_action_just_pressed("ui_left"):
			selected_bloc -= 1
			
			if selected_bloc < 0:
				selected_bloc = blocs.size() -1
				
			update_bloc_selector_pos()
			
		if Input.is_action_just_pressed("ui_accept"):
			set_bloc.emit(blocs[selected_bloc])
			set_mode(Enum.BottomMode.None)
		
func update_bloc_selector_pos():
	%AddMode/BlocSelector.position.x = selected_bloc * 34 + 4

func set_mode(new_mode: Enum.BottomMode) -> void:
	mode = new_mode
	
	if mode == Enum.BottomMode.None:
		%AddMode.visible = false
		
	if mode == Enum.BottomMode.Add:
		%AddMode.visible = true
