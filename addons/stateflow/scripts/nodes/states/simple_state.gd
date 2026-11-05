class_name SimpleState extends StateBase

@export var print_on_enter: bool = false
@export var print_on_exit: bool = false

func _on_enter() -> void:
    if print_on_enter:
        print("[StateFlow] State '", name,"' has been entered.")

func _on_exit() -> void: 
    if print_on_enter:
        print("[StateFlow] State '", name,"' has been exited.")