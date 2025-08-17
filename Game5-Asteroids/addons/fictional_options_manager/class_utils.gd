class_name ClassUtils extends Node
## Provides utility functions to handle types directly, instead of instances or variables.
##
## This class supports user-created [Script]s and Native Classes like [Object], [Resource] and [Node].
## [br]Scripts without class_name, as inner classes or generated in runtime are [b]NOT[/b] supported,
## they will probably show as a basic type, like [RefCounted] or [GDScript].
## [br]Only Native Classes exposed to GDScript are supported.

const _SCRIPT_BODY_EDITOR := "static func eval():
	var class_type = %s
	var _class_object : %s
	return class_type"

const _SCRIPT_BODY_RUNTIME := "static func eval(): return %s"

static var _script : GDScript = GDScript.new()


## Returns an [Object] that represents the type of a Native Class or user-defined Script.
## [br]It produces a result similar to [code]var class_type = Node as Object[/code].
static func get_type(classname: String) -> Object:
	var result : Object
	
	if is_script(classname):
		for inner_script in ProjectSettings.get_global_class_list():
			if inner_script["class"] == classname:
				result = load(inner_script["path"])
				break
	
	return result


## Checks if a [param class_type] is a reference or name that matches an existing user-defined Script.
## Similar to [code]is GDScript[/code], but also accepts string names.
static func is_script(script) -> bool:
	var script_name : String
	
	if script is GDScript:
		return true
	elif script is String:
		script_name = script

	if not script or script_name.is_empty():
		return false
	
	var result := false
	for inner_script in ProjectSettings.get_global_class_list():
		if inner_script["class"] == script_name:
			result = true
			break
	
	return result
