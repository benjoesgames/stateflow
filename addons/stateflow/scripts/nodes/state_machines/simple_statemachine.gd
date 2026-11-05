class_name SimpleStateMachine extends StateMachineBase

@export var print_on_start: bool = false
@export var print_on_pause: bool = false
@export var print_on_resume: bool = false
@export var print_on_stop: bool = false
@export var print_on_state_change: bool = false

func _on_start() -> void:
    if print_on_start:
        print("[StateFlow] StateMachine '", name, "' has been started.")

func _on_pause() -> void:
    if print_on_pause:
        print("[StateFlow] StateMachine '", name, "' has been paused.")

func _on_resume() -> void:
    if print_on_resume:
        print("[StateFlow] StateMachine '", name, "' has been resumed.")

func _on_stop() -> void:
    if print_on_stop:
        print("[StateFlow] StateMachine '", name, "' has been stopped.")

func _on_new_state(old_state: StateBase, new_state: StateBase) -> void:
    if print_on_state_change:
        var old_name: String = old_state.name if old_state else "null"
        var new_name: String = new_state.name if new_state else "null"
        print("[StateFlow] StateMachine '", name, "' changed state from: '", old_name, "', to: '", new_name, "'.")