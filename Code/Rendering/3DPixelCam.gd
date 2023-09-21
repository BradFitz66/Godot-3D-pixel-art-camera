class_name Camera3DTexelSnapped
extends Camera3D

var texel_error: Vector2

var _last_rot: Vector3
var _snap_space: Transform3D


func _process(_delta):
	if global_rotation != _last_rot:
		_last_rot = global_rotation
		_snap_space = global_transform
	var texel_snap := float(get_viewport().size.y) / size
	var snap_space_pos := global_position * _snap_space
	var snapped_snap_space_pos: Vector3 = floor(snap_space_pos * texel_snap) / texel_snap
	var snap_error := snapped_snap_space_pos - snap_space_pos
	h_offset = snap_error.x
	v_offset = snap_error.y
	# NOTE(david): use error to shift the viewport texture on TextureRect/Sprite3D/etc. for extra smooth
	texel_error = Vector2(snap_error.x, -snap_error.y) * texel_snap
