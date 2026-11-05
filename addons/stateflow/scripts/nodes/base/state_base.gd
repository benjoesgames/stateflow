class_name StateBase extends EventBase

@export var triggers: Array[TriggerBase]

signal entered()
signal exited()

func enter() -> void:
    active = true
    _on_enter()
    _set_triggers_active(true)
    entered.emit()

func exit() -> void:
    active = false
    _on_exit()
    exited.emit()
    _set_triggers_active(false)

func update(delta: float) -> void:
    _on_update(delta)
    _update_triggers(delta)

func physics_update(delta: float) -> void:
    _on_physics_update(delta)
    _physics_update_triggers(delta)

func input(event: InputEvent) -> void:
    _on_input(event)
    _input_triggers(event)

func _set_triggers_active(is_active: bool) -> void:
    for t in triggers:
        if is_active:
            t.enter()
        else:
            t.exit()

func _update_triggers(delta: float) -> void:
    for t in triggers:
        t.update(delta)

func _physics_update_triggers(delta: float) -> void:
    for t in triggers:
        t.physics_update(delta)

func _input_triggers(event: InputEvent) -> void:
    for t in triggers:
        t.input(event)

func _on_enter() -> void:
    pass

func _on_exit() -> void:
    pass

func _on_update(_delta: float) -> void:
    pass
    
func _on_physics_update(_delta: float) -> void:
    pass
    
func _on_input(_event: InputEvent) -> void:
    pass

func _on_execute() -> void:
    state_machine.set_state(self)
