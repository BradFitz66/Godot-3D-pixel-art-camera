extends Camera3D

#Resolution is 320x180 with some padding to account for the screen texel error
const width: int = 428
const height: int = 242

const orthographic_size: float = 8
const texel_snap: float = float(height) / orthographic_size

@export var cam_proxy: Node3D
@export var cam: Node3D
@export  var render_texture : TextureRect 

var last_rot :Vector3
var snap_space : Transform3D
#Create a transform with a 45 degree rotation on the y axis
func _ready():
    last_rot = cam_proxy.global_rotation
    snap_space = cam_proxy.global_transform

func _process(_delta): 
    if cam_proxy.global_rotation != last_rot: 
        last_rot = cam_proxy.global_rotation 
        snap_space = cam_proxy.global_transform

    var snap_space_pos := cam_proxy.global_position * snap_space 
    var snapped_snap_space_pos: Vector3 = floor(snap_space_pos * texel_snap) / texel_snap
    cam.global_position = snap_space * snapped_snap_space_pos
    cam.global_rotation = cam_proxy.global_rotation

    var snap_space_error := snapped_snap_space_pos - snap_space_pos
    var screen_texel_error := Vector2(snap_space_error.x, -snap_space_error.y) * texel_snap
    render_texture.position = screen_texel_error

