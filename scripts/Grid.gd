extends Node2D

@export var grid_width = 16
@export var grid_height = 7

@export_category("Sprites")
@export var spr_grid: Texture2D
@export var spr_grid_selected: Texture2D

var grid: Array[Sprite2D] = []

var is_selected = true
var select_position_x = 0
var select_position_y = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for dy in range(grid_height):
		for dx in range(grid_width):
			var sprite = Sprite2D.new()
			sprite.texture = spr_grid
			sprite.centered = false
			
			sprite.position.x = 7 + dx * 18
			sprite.position.y = 30 + dy * 18
			
			grid.insert(dx + dy * grid_width, sprite)
			add_child(sprite)
	
	update_selected_sprite(true)
	
func update_selected_sprite(is_selected: bool) -> void:
	if is_selected:
		grid[select_position_x + select_position_y * grid_width].texture = spr_grid_selected
	else:
		grid[select_position_x + select_position_y * grid_width].texture = spr_grid		
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		update_selected_sprite(false)
		select_position_x -= 1
		
		if select_position_x < 0:
			select_position_x = grid_width - 1
		
		update_selected_sprite(true)

	if Input.is_action_just_pressed("ui_right"):
		update_selected_sprite(false)
		
		select_position_x += 1
		
		if select_position_x >= grid_width:
			select_position_x = 0
			
		update_selected_sprite(true)
		
	if Input.is_action_just_pressed("ui_up"):
		update_selected_sprite(false)
		select_position_y -= 1
		
		if select_position_y < 0:
			select_position_y = grid_height - 1
		
		update_selected_sprite(true)

	if Input.is_action_just_pressed("ui_down"):
		update_selected_sprite(false)
		
		select_position_y += 1
		
		if select_position_y >= grid_height:
			select_position_y = 0
			
		update_selected_sprite(true)