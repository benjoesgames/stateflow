@tool
class_name InputVectorTrigger extends TriggerBase

enum ComparisonType {
	LENGHT_GREATER_THAN,
	LENGTH_EQUALS,
	LENGHT_SMALLER_THAN
}

@export var negative_x: String
@export var positive_x: String
@export var negative_y: String
@export var positive_y: String
@export var deadzone: float = -1.0
@export var comparison_type: ComparisonType = ComparisonType.LENGHT_GREATER_THAN
@export var compared_value: float = 1.0

func _on_update(_delta: float) -> void:
	var current_input: Vector2 = Input.get_vector(negative_x, positive_x, negative_y, positive_x, deadzone)
	var length: float = current_input.length()
	match comparison_type:
		ComparisonType.LENGHT_GREATER_THAN:
			if length > compared_value:
				trigger()
		ComparisonType.LENGTH_EQUALS:
			if length == compared_value:
				trigger()
		ComparisonType.LENGHT_SMALLER_THAN:
			if length < compared_value:
				trigger()

func _validate_property(property: Dictionary) -> void:
	match property.name:
		"negative_x", "positive_x", "negative_y", "positive_y":
			property.hint = PROPERTY_HINT_INPUT_NAME