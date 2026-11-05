class_name TriggerBase extends StateFlowBase

@export var events: Array[EventBase]
@export_group("Reset settings", "reset_")
@export var reset_on_enter: bool = false
@export var reset_on_exit: bool = false
@export var reset_on_trigger: bool = false

var _triggered: bool = false

func enter() -> void:
    active = true
    _on_enter()
    if reset_on_enter: reset()

func exit() -> void:
    active = false
    _on_exit()
    if reset_on_exit: reset()

func update(delta: float) -> void:
    _on_update(delta)
    if not _triggered and test():
        trigger()

func physics_update(delta: float) -> void:
    _on_physics_update(delta)

func input(event: InputEvent) -> void:
    _on_input(event)

func test() -> bool:
    return _on_test()

func trigger() -> void:
    _triggered = true
    _on_trigger()
    _execute_events()
    if reset_on_trigger: reset()

func reset() -> void:
    _triggered = false
    _on_reset()

func _execute_events() -> void:
    for e in events:
        e.execute()

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

func _on_test() -> bool:
    return true

func _on_trigger() -> void:
    pass

func _on_reset() -> void:
    pass