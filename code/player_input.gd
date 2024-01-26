extends Node



func movement_vector(id):
	return Input.get_vector("left_"+str(id), "right_"+str(id), "up_"+str(id), "down_"+str(id))
