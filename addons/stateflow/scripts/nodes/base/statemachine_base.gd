class_name StateMachineBase extends StateFlowBase

@export var auto_start: bool = true
@export var start_state: StateBase

var current_state: StateBase

func _ready() -> void:
    if auto_start:
        start()

func _process(delta: float) -> void:
    if not active: return
    if current_state:
        current_state.update(delta)

func _physics_process(delta: float) -> void:
    if not active: return
    if current_state:
        current_state.physics_update(delta)

func _input(event: InputEvent) -> void:
    if not active: return
    if current_state:
        current_state.input(event)

func start(force_restart: bool = false) -> void:
    active = true
    if not current_state or force_restart:
        set_state(start_state)
        _on_start()
    else:
        _on_resume()

func pause() -> void:
    active = false
    _on_pause()

func stop() -> void:
    active = false
    set_state(null)
    _on_stop()

func set_state(state: StateBase) -> void:
    var old_state: StateBase = current_state
    if current_state: current_state.exit()
    current_state = state
    if current_state: current_state.enter()
    _on_new_state(old_state, state)

func _on_start() -> void:
    pass

func _on_pause() -> void:
    pass

func _on_resume() -> void:
    pass

func _on_stop() -> void:
    pass

func _on_new_state(_old_state: StateBase, _new_state: StateBase) -> void:
    pass
