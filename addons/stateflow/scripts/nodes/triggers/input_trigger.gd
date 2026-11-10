@tool
class_name InputTrigger extends TriggerBase

@export var input_action: String
@export var trigger_on_down: bool = true
@export var trigger_on_up: bool = false

func _on_update(_delta: float) -> void:
	if trigger_on_down and Input.is_action_just_pressed(input_action):
		trigger()
	if trigger_on_up and Input.is_action_just_released(input_action):
		trigger()

func _validate_property(property: Dictionary) -> void:
	match property.name:
		"input_action":
			property.hint = PROPERTY_HINT_INPUT_NAME