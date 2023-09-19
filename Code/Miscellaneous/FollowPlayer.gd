extends Node3D
@export var Player:CharacterBody3D;
@export var Camera:Camera3D;
func _process(_delta):
    position = Player.position;
