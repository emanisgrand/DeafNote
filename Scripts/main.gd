extends Control

@export var auto_delete_time: float = 30.0  # Default auto-delete timer (seconds)

var selected_label: Label = null
var dragging: bool = false
var touch_start_distance: float = 0.0  # Used for pinch-to-zoom

func _ready():
	set_process_input(true)

# Handle user input
func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			_create_text_box(event.position)
		else:
			dragging = false  # Stop dragging when touch is released

	elif event is InputEventScreenDrag and selected_label:
		selected_label.global_position += event.relative  # Dragging logic

	elif event is InputEventGesture and selected_label:
		_resize_text(event)

# Creates a floating text box at the tap location
func _create_text_box(position: Vector2):
	var new_label = Label.new()
	new_label.text = "Type here..."
	new_label.add_theme_font_size_override("font_size", 48)
	new_label.add_theme_color_override("font_color", Color.WHITE)
	new_label.global_position = position
	new_label.mouse_filter = Control.MOUSE_FILTER_IGNORE  # Avoid accidental clicks
	new_label.name = "FloatingText"

	# Enable dragging by tracking the selected label
	new_label.gui_input.connect(_on_text_gui_input.bind(new_label))
	add_child(new_label)

	# Set auto-delete timer unless marked as permanent
	var timer = Timer.new()
	timer.wait_time = auto_delete_time
	timer.one_shot = true
	timer.timeout.connect(_delete_text.bind(new_label))
	add_child(timer)
	timer.start()

# Resizes text dynamically using pinch gesture
func _resize_text(event: InputEventGesture):
	if event.factor != 0:
		var current_size = selected_label.get_theme_font_size("font_size")
		selected_label.add_theme_font_size_override("font_size", clamp(current_size * event.factor, 20, 200))

# Handles text selection for dragging
func _on_text_gui_input(event: InputEvent, label: Label):
	if event is InputEventScreenTouch and event.pressed:
		selected_label = label
		dragging = true

# Deletes text
func _delete_text(label: Label):
	if label:
		label.queue_free()
