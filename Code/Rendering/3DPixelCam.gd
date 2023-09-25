class_name Camera3DTexelSnapped
extends Camera3D


var texel_error: Vector2

var _last_rot: Vector3
var _snap_space: Transform3D
var snappables: Array = []
var pixel_size:float = 0.032
@onready var pixel_length = float(2.0 * size) / float(get_viewport().size.y * 1.0)

func _ready():
    get_tree().process_frame.connect(after_render)
    RenderingServer.connect("frame_pre_draw", before_render)
    

func before_process():
    pass
func before_render():
    pass


func after_render():
    for snappable in snappables:
        snappable.call("restore_transform")

func _process(_delta):
    snappables = get_tree().get_nodes_in_group("Snappables")
    get_tree().call_group("Snappables", "save_transform")
    var cam_to_world:Transform3D = get_camera_transform()
    var world_to_cam:Transform3D = get_camera_transform().affine_inverse()


    for snappable in snappables:    

        var pixel_pos_cam_space = (world_to_cam * snappable.global_position) / pixel_length
        var rounded_pos = Vector3(
            round(pixel_pos_cam_space.x)+0.5,
            round(pixel_pos_cam_space.y)+0.5,
            round(pixel_pos_cam_space.z)+0.5
        )
        snappable.global_position = cam_to_world * (rounded_pos * pixel_length)

    # if global_rotation != _last_rot:
    #     _last_rot = global_rotation
    #     _snap_space = global_transform
    # var texel_snap := float(get_viewport().size.y) / size
    # var snap_space_pos := global_position * _snap_space
    # var snapped_snap_space_pos: Vector3 = floor(snap_space_pos * texel_snap) / texel_snap
    # var snap_error := snapped_snap_space_pos - snap_space_pos
    # h_offset = snap_error.x
    # v_offset = snap_error.y
    # # NOTE(david): use error to shift the viewport texture on TextureRect/Sprite3D/etc. for extra smooth
    # texel_error = Vector2(snap_error.x, -snap_error.y) * texel_snap

    
    
