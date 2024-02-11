extends Node2D

signal button_pressed(btn: Enum.ButtonType)
signal leave(direction: int)

var is_selected = false
var index = 0

var lock = false

func _ready() -> void:
	$ButtonSelector.visible = false

func _process(delta: float) -> void:
	if is_selected:
		if Input.is_action_just_pressed("ui_up"):
			if !lock:	
				leave.emit(-1)
				is_selected = false
				$ButtonSelector.visible = false
				
		if Input.is_action_just_pressed("ui_down"):
			if !lock:
				leave.emit(1)
				is_selected = false
				$ButtonSelector.visible = false
		
		if Input.is_action_just_pressed("ui_left"):
			index -= 1
			
			if index < 0:
				index = 2
				
			update_selector_position()
			
		if Input.is_action_just_pressed("ui_right"):
			index += 1
			
			if index > 2:
				index = 0
				
			update_selector_position()
			
		if Input.is_action_just_pressed("ui_accept"):
			if index == 0:
				button_pressed.emit(Enum.ButtonType.Step)
				lock = true
				#is_selected = false
				#$ButtonSelector.visible = false
			
			elif index == 1:
				button_pressed.emit(Enum.ButtonType.Stop)
				#is_selected = false
				#$ButtonSelector.visible = false
				
			elif index == 2:
				button_pressed.emit(Enum.ButtonType.Play)
				lock = true
				#is_selected = false
				#$ButtonSelector.visible = false

func select():
	is_selected = true
	index = 0
	
	$ButtonSelector.visible = true
	update_selector_position()

func update_selector_position():
	$ButtonSelector.position.x = 14 * index + 4
