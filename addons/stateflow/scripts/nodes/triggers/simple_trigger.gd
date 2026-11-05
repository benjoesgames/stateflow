class_name SimpleTrigger extends TriggerBase

@export var print_on_trigger: bool = false
@export var print_on_reset: bool = false

func _on_trigger() -> void:
    if print_on_trigger:
        print("[StateFlow] Trigger'", name, "' has been triggered.")

func _on_reset() -> void:
    if print_on_reset:
        print("[StateFlow] Trigger'", name, "' has been reset.")