"""
Original code by DenovoDavid on reddit, which can be found here:
https://www.reddit.com/r/godot/comments/14as2b9/i_added_a_stable_subtexel_smooth_camera_to_my_3d/jq3eig2/?context=3
"""

extends Camera3D

const width: int = 642
const height: int = 362

const orthographic_size: float = 10
const texel_snap: float = float(height) / orthographic_size

@export var cam_proxy: Node3D
@export var render_texture: TextureRect 

var last_rot: Vector3
var snap_space: Transform3D

func _ready():
    last_rot = cam_proxy.global_rotation
    snap_space = cam_proxy.global_transform

func _process(_delta): 
    if cam_proxy.global_rotation != last_rot: 
        last_rot = cam_proxy.global_rotation 
        snap_space = cam_proxy.global_transform

    var snap_space_pos := cam_proxy.global_position * snap_space
    var snapped_snap_space_pos: Vector3 = floor(snap_space_pos * texel_snap) / texel_snap
    global_position = snap_space * snapped_snap_space_pos
    global_rotation = cam_proxy.global_rotation

    var snap_space_error := snapped_snap_space_pos - snap_space_pos
    var screen_texel_error := Vector2(snap_space_error.x, -snap_space_error.y) * texel_snap
    render_texture.position = screen_texel_error

