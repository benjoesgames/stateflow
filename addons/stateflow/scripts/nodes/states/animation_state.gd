@tool
class_name AnimationState extends StateBase

@export var animator: AnimationPlayer:
	set(value):
		animator = value
		notify_property_list_changed()
		if not animator:
			animation_name = ""
@export var animation_name: String:
	set(value):
		animation_name = value
		notify_property_list_changed()
@export var custom_blend: float = -1
@export var custom_speed: float = 1
@export var from_end: bool = false

func _on_enter() -> void:
	if animator and not animation_name.is_empty():
		animator.play(animation_name, custom_blend, custom_speed, from_end)

func _on_exit() -> void:
	pass

func _on_update(delta: float) -> void:
	pass
	
func _on_physics_update(delta: float) -> void:
	pass
	
func _on_input(event: InputEvent) -> void:
	pass

func _validate_property(property: Dictionary) -> void:
	match property.name:
		"animation_name":
			if not animator:
				property.usage = PROPERTY_USAGE_NONE
			else:
				var animations: PackedStringArray = animator.get_animation_list()
				property.hint = PROPERTY_HINT_ENUM
				property.hint_string = ",".join(animations)
		"custom_blend", "custom_speed", "from_end":
			if not animator or animation_name.is_empty():
				property.usage = PROPERTY_USAGE_NONE

