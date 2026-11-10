@tool
class_name ChangePropertyEvent extends EventBase

const INVALID_USAGES: Array[PropertyUsageFlags] = [
	PROPERTY_USAGE_GROUP,
	PROPERTY_USAGE_SUBGROUP,
	PROPERTY_USAGE_CATEGORY
]

@export var node: Node:
	set(value):
		node = value
		notify_property_list_changed()
		if not node:
			property_name = ""
@export var property_name: String:
	set(value):
		property_name = value
		notify_property_list_changed()
		if node and not property_name.is_empty():
			new_value = null

@export var new_value: Variant

func _on_execute() -> void:
	if node and not property_name.is_empty():
		node.set(property_name, new_value)

func _validate_property(property: Dictionary) -> void:
	match property.name:
		"property_name":
			if not node:
				property.usage = PROPERTY_USAGE_NONE
			else:
				var properties: Array[Dictionary] = node.get_property_list()
				var prop_names: Array[String] = []
				for p in properties:
					if not INVALID_USAGES.has(p.usage):
						prop_names.append(p.name)
				property.hint = PROPERTY_HINT_ENUM
				property.hint_string = ",".join(prop_names)
		"new_value":
			if not node or property_name.is_empty():
				property.usage = PROPERTY_USAGE_NONE
			else:
				var properties: Array[Dictionary] = node.get_property_list()
				var prop_id: int = properties.find_custom(func(x): return x.name == property_name)
				var prop: Dictionary = properties[prop_id]
				property.type = prop.type
				property.hint = prop.hint
				property.hint_string = prop.hint_string
				property.class_name = prop.class_name