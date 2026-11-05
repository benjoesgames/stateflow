class_name StateTrigger extends TriggerBase

@export var state: StateBase
@export var trigger_on_enter: bool = false
@export var trigger_on_exit: bool = false

func _on_enter() -> void:
    if trigger_on_enter:
        state.entered.connect(trigger)
    if trigger_on_exit:
        state.exited.connect(trigger)

func _on_exit() -> void:
    if trigger_on_enter:
        state.entered.disconnect(trigger)
    if trigger_on_exit:
        state.exited.disconnect(trigger)
