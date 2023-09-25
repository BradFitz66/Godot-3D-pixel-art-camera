extends Node3D

var saved_transform:Transform3D
var saved_position:Vector3
var saved_rotation:Vector3


func save_transform():
    saved_transform = global_transform

func restore_transform():
    global_transform = saved_transform

