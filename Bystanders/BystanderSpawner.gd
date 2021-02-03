extends Spatial

export var max_wait = 5

const BYSTANDER_SPEED = 10

var bystanders = {}

func _ready():
	bystanders = FileGrabber.get_files("res://Bystanders/Bystander_figures/")
	randomize()
	set_timer()

func set_timer():
	$Timer.wait_time = randi() % max_wait +1

func _on_Timer_timeout():
	set_timer()
	spawn()

func spawn():
	var bystander = load(bystanders [randi() % bystanders.size()]).instance()
	add_child(bystander)
	bystander.set_as_toplevel(true)
	bystander.global_transform = $Forward.global_transform
	
	var spawner_forward = global_transform.basis[2].normalized()
	bystander.linear_velocity = spawner_forward * BYSTANDER_SPEED
