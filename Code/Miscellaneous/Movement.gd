extends Node3D

@export var end_point: Vector3
var start_point: Vector3
var t = 0.0
@export var speed = 1.0
func _ready():
    start_point = self.global_transform.origin

func _process(delta):
    #Lerp between start and end point, then back again with speed
    t += delta * speed
    if t > 1.0:
        t = 0.0
        var temp = start_point
        start_point = end_point
        end_point = temp

    self.global_transform.origin = start_point.lerp(end_point, t)