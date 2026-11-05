class_name StateFlowBase extends Node

var active: bool = false

var state_machine: StateMachineBase : 
    get:
        var result: Node = self
        while result and not result is StateMachineBase:
            result = result.get_parent()
        return result