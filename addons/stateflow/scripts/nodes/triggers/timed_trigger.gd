class_name TimedTrigger extends TriggerBase

@export var time: float = 1.0

var _timer: float = 0.0

func _on_update(_delta: float) -> void:
    _timer += _delta

func _on_test() -> bool:
    return _timer >= time

func _on_reset() -> void:
    _timer = 0.0
