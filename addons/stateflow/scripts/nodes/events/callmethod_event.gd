@tool
class_name CallMethodEvent extends EventBase

@export var node: Node:
    set(value):
        node = value
        notify_property_list_changed()
        if not node:
            method_name = ""
@export var method_name: String:
    set(value):
        method_name = value
        notify_property_list_changed()
        if node and not method_name.is_empty():
            var method: Dictionary = get_method(node, method_name)
            argument_order.clear()
            for a in method.args:
                argument_order.append(a.name)
                if not arguments.has(a.name):
                    arguments[a.name] = null
            for k in arguments.keys():
                if not argument_order.has(k):
                    arguments.erase(k)
@export var arguments: Dictionary[String,Variant]
@export_storage var argument_order: Array[String]

func _on_execute() -> void:
    match arguments.size():
        0:
            node.call(method_name)
        1:
            node.call(method_name, arguments[arguments.keys()[0]])
        _:
            var args: Array = []
            for a in argument_order:
                if arguments[a] is NodePath:
                    args.append(get_node(arguments[a]))
                else:
                    args.append(arguments[a])
            node.callv(method_name, args)

func _validate_property(property: Dictionary) -> void:
    match property.name:
        "method_name":
            property.hint = PROPERTY_HINT_ENUM
            if not node:
                property.usage |= PROPERTY_USAGE_READ_ONLY
            else:
                var hint_string: String = ",".join(node.get_method_list().map(func(x): return x.name))
                property.hint_string = hint_string
        "arguments":
            if not node or method_name.is_empty() or node.get_method_argument_count(method_name) <= 0:
                property.usage = PROPERTY_USAGE_NONE

static func get_method(node: Node, method_name: String) -> Dictionary:
    var method_list: Array[Dictionary] = node.get_method_list()
    var method_index: int = method_list.find_custom(func(x): return x.name == method_name)
    return method_list[method_index]