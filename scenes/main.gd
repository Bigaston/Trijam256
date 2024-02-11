extends Node2D

func _on_grid_toggle_add() -> void:
	await get_tree().create_timer(0.001).timeout
	$BottomPatch.set_mode(Enum.BottomMode.Add)

func _on_bottom_patch_set_bloc(bloc: PackedScene) -> void:
	$Grid.set_bloc(bloc)
