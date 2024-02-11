extends Node2D

@export var sounds: Array[AudioStream] = []

@onready var Audio: AudioStreamPlayer = $Audio

var is_step = false
var is_play = false
var play_array: Array[int] = []
var current_step = 0

func _on_grid_toggle_add() -> void:
	await get_tree().create_timer(0.001).timeout
	$BottomPatch.set_mode(Enum.BottomMode.Add)

func _on_bottom_patch_set_bloc(bloc: PackedScene) -> void:
	$Grid.set_bloc(bloc)

func _on_grid_go_to_button() -> void:
	await get_tree().create_timer(0.001).timeout	
	$Buttons.select()

func _on_buttons_leave(direction: int) -> void:
	await get_tree().create_timer(0.001).timeout
	$Grid.select(direction)

func _on_buttons_button_pressed(btn: int) -> void:
	match btn:
		Enum.ButtonType.Play:
			if is_play:
				return
				
			if is_step:
				is_step = false
			
			is_play = true
			
			Memory.reset()
			play_array = []
			
			for step in range($Grid.grid.size()):
				var item = $Grid.grid[step]
	
				if item is Output:
					play_array.push_back(item.action())
				elif item is Bloc:
					item.action()
					
			for note in play_array.size():
				play_sound(play_array[note])
				await get_tree().create_timer(0.5).timeout
				
			
			$Buttons.lock = false
			
			is_play = false
		Enum.ButtonType.Step:
			if is_play:
				return
				
			if is_step:
				process_step()
			else:
				Memory.reset()
				
				is_step = true
				
				current_step = 0
				process_step()
		Enum.ButtonType.Stop:
			$Buttons.lock = false
			
			is_step = false
			Memory.reset()

func process_step():
	var item = $Grid.grid[current_step]
	
	if item is Output:
		var sound_id = item.action()
		play_sound(sound_id)
	elif item is Bloc:
		item.action()
		
	current_step += 1
	
	if current_step >= $Grid.grid.size():
		$Buttons.lock = false
			
		is_step = false
		Memory.reset()

func play_sound(id: int):
	Audio.stream = sounds[id]
	Audio.play()
