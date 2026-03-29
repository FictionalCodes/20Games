class_name ShipSystemHelpers extends RefCounted


static func CreateAutoPowerSystem(name: String, type: ShipSystemBase.ShipSystemTypes) -> ShipSystemAutoPower:
	var newSystem := ShipSystemAutoPower.new(name, type)
	newSystem.initalise_system(1)
	return newSystem

static func CreateTogglePowerSystemBase(name: String, type: ShipSystemBase.ShipSystemTypes) -> ShipSystemToggle:
	var newSystem := ShipSystemToggle.new(name, type)
	newSystem.initalise_system(1)

	return newSystem

static func CreateTogglePowerSystem(name: String, type: ShipSystemBase.ShipSystemTypes, powerUp: Callable, powerDown: Callable) -> ShipSystemToggle:
	var system = CreateTogglePowerSystemBase(name, type)
	system.bind(powerUp, powerDown)
	return system

static func CreateShieldSystem(powerUp: Callable, powerDown: Callable) -> ShipSystemToggle:
	var newSystem := CreateTogglePowerSystemBase("Shields", ShipSystemBase.ShipSystemTypes.SHIELDS)
	newSystem.power_step = 2
	newSystem.initalise_system(4)
	newSystem.bind(powerUp, powerDown)
	return newSystem
