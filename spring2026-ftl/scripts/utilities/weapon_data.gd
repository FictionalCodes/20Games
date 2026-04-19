class_name WeaponData extends Resource

enum WeaponType{
	PROJECTILE,
	MISSILE,
	BEAM
}

@export_category("Visuals")
@export var name : String = "Lazer"
@export var weapon_texture : Texture2D
@export var shot_texture : Texture2D

@export_category("Stats")
@export var power_use : int = 2
@export var secs_to_charge : float = 6.0
@export var damage : int = 1
@export var number_shots : int = 2
@export var weapon_type: WeaponType = WeaponType.PROJECTILE
