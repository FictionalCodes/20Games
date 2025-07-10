class_name AsteroidSpawner extends Path2D

@onready var spawningPoint := $SpawnPoint as PathFollow2D
@onready var spawnTimer := $Timer as Timer

@export var possibleSpawns: Array[PackedScene]
@export var bigOnKillSpawns: Array[PackedScene]
@export var medOnKillSpawns: Array[PackedScene]

@export var minSpawnTime: float = 2.0
@export var maxSpawnTime: float = 5.0

var rocks : Array[Asteroid] = []
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
	rocks.push_back(spawnedRock)
	
func rock_dead(rock: Asteroid) -> void:
	var arrayToChooseFrom : Array[PackedScene]
	rocks.erase(rock)

	match rock.size:
		Asteroid.Size.Big:
			scoreCallback.call(1)
			arrayToChooseFrom = bigOnKillSpawns
		Asteroid.Size.Med:
			scoreCallback.call(2)
			arrayToChooseFrom = medOnKillSpawns
		Asteroid.Size.Small:
			scoreCallback.call(3)
	
	if arrayToChooseFrom == null or arrayToChooseFrom.is_empty():
		if rocks.is_empty():
			_on_timer_timeout()
		return
				
	for i in getAsteroidSpawnNumber():
		var spawnedRock : Asteroid = arrayToChooseFrom.pick_random().instantiate()
		spawnedRock.global_position = rock.global_position
		# to determine rough yeet direction we get the center of the view and grab the sign of each bit
		spawnedRock.yeet_random()
		spawnedRock.On_kill_callback = rock_dead
		add_child(spawnedRock, true)

func getAsteroidSpawnNumber() -> int:
	var spawnRandom = randf()
	var numSpawn = 2
	if spawnRandom < 0.25:
		numSpawn = 1
	elif spawnRandom > 0.75:
		numSpawn = 3
	
	return numSpawn

func _on_timer_timeout() -> void:
	var numberToMake = getAsteroidSpawnNumber()
	for i in numberToMake:
		spawn_rock() # Replace with function body.
	
	var timer = randf_range(minSpawnTime, maxSpawnTime) * numberToMake
	spawnTimer.wait_time = timer
 

func start() -> void:
	stop()
	spawnTimer.start()
	
func stop() -> void:
	spawnTimer.stop()
	for rock in rocks:
		rock.kill_when_leave_screen = true
	
	rocks.clear()
