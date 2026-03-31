class_name WeaponData extends Resource

enum WeaponType{
	PROJECTILE,
	MISSILE,
	BEAM
}

@export_category("Visuals")
@export var weapon_texture : Texture2D
@export var shot_texture : Texture2D

@export_category("Stats")
@export var power_use : int
@export var secs_to_charge : float
@export var damage : int
@export var number_shots : int
