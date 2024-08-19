class_name Interfaces
extends Node

static func check(target: Object, method: String, argc: int) -> bool:
	if target == null: return false
	if not target.has_method(method): return false
	var m: Callable = target.get(method) as Callable
	var actual_argc := m.get_argument_count()
	if argc != actual_argc: return false
	return true

static func expect(target: Object, method: String, argc: int) -> Callable:
	assert(target != null, "target is null")
	assert(target.has_method(method), "target lacks method " + method)
	var m: Callable = target.get(method) as Callable
	assert(m != null, "method isn't Callable, or is null")
	var real_argc := m.get_argument_count()
	assert(argc == real_argc, "method " + str(method) + " on target has wrong argc: " + str(real_argc) + " (expected " + str(argc) + ")")
	return m
