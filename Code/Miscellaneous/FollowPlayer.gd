extends Node3D
@export var Player:CharacterBody3D;
@export var Camera:Camera3D;
func _physics_process(_delta):
    position = Player.position;
    if(Input.is_action_just_pressed("right_mouse")):
        rotation_degrees.y += 45;
