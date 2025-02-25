extends Resource
class_name NoteData

@export var title: String = "Untitled Note"
@export var content: String = ""  # Main text content
@export var category: String = "General"  # Used for organization
@export var tags: Array[String] = []  # Freeform metadata
@export var modifiers: Dictionary = {}  # Holds additional features like "Pinned": true

# Spatial properties
@export var position: Vector2 = Vector2.ZERO  # Where it's placed
@export var size: Vector2 = Vector2(300, 150)  # Default size in pixels
@export var flipped: bool = false  # Whether it's flipped for recipient view

# Multi-modal input support
@export var drawing_data: PackedByteArray = []  # Stores drawing strokes
@export var cost_value: float = 0.0  # Stores a cost if entered

# Lifecycle
@export var created_at: float = Time.get_unix_time_from_system()
@export var expires_at: float = 0.0  # 0 means no auto-deletion
