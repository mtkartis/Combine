class_name Combine
extends KinematicBody2D


export(Resource) var silo_ref = null

var hopper = Hopper.new()

const WHEEL_BASE = 376
const STEER_ANGLE = 30 #degrees
const MAX_SPEED = 500
const ACCELERATION = 500

var velocity = Vector2.ZERO
var angle = 0

onready var cutter = $Cutter
onready var combine = $Body
onready var interact_sense = $InteractSense
onready var compass = $Compass

signal fill_silo
signal fill_hopper
#-------------------------------------------------------------------------------
func _ready():
	hopper.fill = Vector2(0, 100)

func _process(_delta):
	var angle_to_silo = get_angle_to(silo_ref.global_position)
	compass.rotation = angle_to_silo
	
	
	var collisions = combine.get_overlapping_areas()
	for i in collisions:
		if i is Crop:
			if i.standing:
				i.flatten()

	var interactive_collisions = interact_sense.get_overlapping_bodies()
	for i in interactive_collisions:
		if i is Silo:
			interact_sense.state = interact_sense.ON
			if Input.is_action_pressed("SPACE"):
				if hopper.subtract(1):
					i.hopper.add(1)
					emit_signal("fill_silo")
					print("filling silo...")

func _physics_process(delta):
	get_input()
	calculate_steering(delta)
	velocity = move_and_slide(velocity)

func get_input()->void:
	var turn = Input.get_action_strength("RIGHT") - Input.get_action_strength("LEFT")
	angle = turn * deg2rad(STEER_ANGLE)
	velocity = Vector2.ZERO
	var accel:float = Input.get_action_strength("UP") - Input.get_action_strength("DOWN")
	if accel != 0.0:
		velocity = transform.x * MAX_SPEED * accel

func calculate_steering(delta)->void:
	var rear_wheel_position = position - transform.x * WHEEL_BASE / 2
	var front_wheel_position = position + transform.x * WHEEL_BASE / 2
	rear_wheel_position += velocity * delta
	front_wheel_position += velocity.rotated(angle) * delta
	var new_heading = (front_wheel_position - rear_wheel_position).normalized()
#	velocity = new_heading * velocity.length()
	rotation = new_heading.angle()



func _on_Cutter_harvest(crop:Crop):
	if hopper.add(1):
		emit_signal("fill_hopper")
		crop.harvest()
