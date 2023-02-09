class_name Crop
extends Area2D

enum {STAND, FLAT, HARVEST}

var image_dictionary = {
	STAND:[0, 1, 2, 3],
	FLAT:[4, 5, 6, 7, 8],
	HARVEST:[9, 10, 11, 12]
}

var standing:bool = true

onready var image = $Sprite
#-------------------------------------------------------------------------------
func _ready():
	var start_frame = randi() % 4
	image.frame = image_dictionary[STAND][start_frame]

func flatten():
	standing = false
	var frame = randi() % 5
	image.frame = image_dictionary[FLAT][frame]
	z_index -= 1

func harvest():
	standing = false
	var frame = randi() % 4
	image.frame = image_dictionary[HARVEST][frame]
