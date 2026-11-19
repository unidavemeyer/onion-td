extends CanvasLayer

var buttons: Array[Button] = []
# NOTE: GDScript (the type) means a script, which I can then call .new() on. I'm essentially holding the class itself.
var placing_tower: GDScript
var button_group: ButtonGroup = ButtonGroup.new()

var tower_dict: Dictionary = {
	# NOTE: The parentheses are to prevent the keys from being turned into StringNames
	(SoupTower): load("res://assets/soup_pot_button.tres"),
	(PepperTower): load("res://assets/pepper_shaker_button.tres")
}

func _process(delta: float) -> void:
	# The built-in Godot input event "ui_cancel" defaults to Escape on keyboards and has various other buttons on other devices.
	if Input.is_action_just_released("ui_cancel"):
		var current_button: Button = button_group.get_pressed_button()
		if current_button != null:
			current_button.button_pressed = false
			placing_tower = null

func _ready() -> void:
	# Make sure the buttons don't overlap
	var button_offset = Vector2(0, 0)
	
	# NOTE: Unlike Python, I can't just say "for key, value in dictionary"
	for tower in tower_dict:
		var button = create_button(tower_dict[tower], tower)
		button.position += button_offset
		add_child(button)
		buttons.append(button)
		button_offset += Vector2(96, 0)

func create_button(texture: Texture, tower_type: GDScript) -> Button:
	var button: Button = Button.new()
	
	# Set up positioning etc. for a 48x32 texture (standard for our towers)
	button.icon = texture
	button.expand_icon = true
	button.size = Vector2i(96, 96)
	button.icon_alignment = HORIZONTAL_ALIGNMENT_CENTER
	button.toggle_mode = true
	button.button_group = button_group
	# .bind() returns a copy of the callable with arguments pre-attached.
	button.pressed.connect(start_placing.bind(tower_type))
	
	return button

func start_placing(tower_type: GDScript):
	placing_tower = tower_type
