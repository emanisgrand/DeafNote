extends Node

# Creates a new note resource
func create_note(text: String, position: Vector2) -> Note:
	var note = Note.new()
	note.text = text
	note.position = position
	note.created_at = Time.get_unix_time_from_system()
	return note

# Moves a note to a new position
func move_note(note: Note, new_position: Vector2):
	note.position = new_position

# Resizes a note
func resize_note(note: Note, new_size: float):
	note.size = clamp(new_size, 20, 200)

# Deletes a note after expiration
func should_delete(note: Note) -> bool:
	return Time.get_unix_time_from_system() > note.expires_at
