@tool
extends EditorInspectorPlugin

func _can_handle(object):
	return object is AnimConfig

func _parse_begin(object):
	pass
