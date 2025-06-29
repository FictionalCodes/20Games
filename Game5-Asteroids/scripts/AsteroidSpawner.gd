class_name AsteroidSpawner extends Path2D

@onready var spawningPoint := $SpawnPoint as PathFollow2D

@export var possibleSpawns: Array[PackedScene]
@export var bigOnKillSpawns: Array[PackedScene]
@export var medOnKillSpawns: Array[PackedScene]

var scoreCallback: Callable

func spawn_rock() -> void:
	spawningPoint.progress_ratio = randf()
	# make a rock
	var spawnedRock : Asteroid = possibleSpawns.pick_random().instantiate()
	spawnedRock.global_position = spawningPoint.global_position
	# to determine rough yeet direction we get the center of the view and grab the sign of each bit
	var direction = Vector2(get_viewport_rect().get_center() - spawnedRock.global_position).sign()
	direction += Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0))
	spawnedRock.yeet(direction.normalized())
	spawnedRock.On_kill_callback = rock_dead

	add_child(spawnedRock)
	
func rock_dead(rock: Asteroid) -> void:
	
	var arrayToChooseFrom : Array[PackedScene]
	match rock.size:
		Asteroid.Size.Big:
			scoreCallback.call(1)
			arrayToChooseFrom = bigOnKillSpawns
		Asteroid.Size.Med:
			scoreCallback.call(2)
			arrayToChooseFrom = medOnKillSpawns
		Asteroid.Size.Small:
			scoreCallback.call(3)
			return
			
	var spawnRandom = randf()
	var numSpawn = 2
	if spawnRandom < 0.25:
		numSpawn = 1
	elif spawnRandom > 0.75:
		numSpawn = 3
	for i in numSpawn:
		var spawnedRock : Asteroid = arrayToChooseFrom.pick_random().instantiate()
		spawnedRock.global_position = rock.global_position
		# to determine rough yeet direction we get the center of the view and grab the sign of each bit
		spawnedRock.yeet_random()
		spawnedRock.On_kill_callback = rock_dead
		add_child(spawnedRock)
	

func _on_timer_timeout() -> void:
	spawn_rock() # Replace with function body.
