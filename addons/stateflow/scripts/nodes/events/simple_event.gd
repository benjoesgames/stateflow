class_name SimpleEvent extends EventBase

@export var print_on_execute: bool = false

func _on_execute() -> void:
    if print_on_execute:
        print("[StateFlow] Event '", name, "' has been executed.")
