extends Node

const CROP = preload("res://Objects/Crop/Crop.tscn")
const SILO = preload("res://Objects/Silo/Silo.tscn")

const CROP_DENSITY = 1000

var silo_ref = null

onready var combine = $Combine
onready var soil_shape = $Soil/Shape
onready var silo_spawn_shape = $SiloSpawn/CollisionShape2D
onready var clock = $UI/Clock
onready var HUD = $UI/HUD
#-------------------------------------------------------------------------------
func _ready():
	set_silo()
	plant_crops()
	clock.set_clock(120)
	clock.start_clock()
	combine.silo_ref = silo_ref

func plant_crops():
	var crop_count:int = 0
	while crop_count < CROP_DENSITY:
		var crop = CROP.instance()
		add_child(crop)
		randomize()
		crop.position = soil_shape.global_position + Vector2(soil_shape.shape.extents.x * rand_range(-1, 1), soil_shape.shape.extents.y * rand_range(-1, 1))
		crop_count += 1
		if !crop.get_overlapping_bodies().empty():
			crop.queue_free()
			crop_count -= 1

func set_silo():
	randomize()
	var silo = SILO.instance()
	add_child(silo)
	silo.position = silo_spawn_shape.global_position + Vector2(silo_spawn_shape.shape.extents.x * rand_range(-1, 1), silo_spawn_shape.shape.extents.y * rand_range(-1, 1))
	silo_ref = silo

func _on_Combine_fill_silo():
	HUD.hopper -= 1
	HUD.silo += 1


func _on_Combine_fill_hopper():
	HUD.hopper += 1


func _on_Clock_done():
	Global.wheat = silo_ref.hopper.fill.x
	
