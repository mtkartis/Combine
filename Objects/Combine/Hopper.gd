class_name Hopper
extends Resource

export(Vector2) var fill
export(bool) var full = false

#-----------------------------
func add(n:int)->bool:
	if fill.y - fill.x > 0:
		if n + fill.x > fill.y: return false
		fill.x += n
		check_full()
		return true
	else:
		full = true
		return false

func subtract(n:int)->bool:
	if fill.y - fill.x < fill.y:
		if fill.x - n < 0: return false
		fill.x -= n
		check_full()
		return true
	else:
		return false

func check_full():
	if fill.x >= fill.y:
		full = true
	else:
		full = false
