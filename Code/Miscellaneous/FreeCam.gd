extends Node3D
func _process(delta):
    var direction = Input.get_vector("left","right","forwards","backwards")
    position+=Vector3(direction.x,0,direction.y)*3*delta
        
