extends Control

@export var viewport: SubViewport
@export var pixel_movement := true
@export var sub_pixel_movement := false

@onready var _display := $Display


func _process(_delta):
	var screen_size := Vector2(get_window().size)
	var game_size := Vector2(viewport.size - Vector2i(2, 2))
	var display_scale := screen_size / game_size

	var display_scale_min: float = min(display_scale.x, display_scale.y)
	_display.scale = Vector2(display_scale_min, display_scale_min)

	size = round(_display.scale * game_size)
	position = round((screen_size - size) / 2)

	if pixel_movement:
		var cam := viewport.get_camera_3d() as Camera3DTexelSnapped
		var pixel_error: Vector2 = cam.texel_error * _display.scale
		_display.position = -_display.scale + pixel_error
		if not sub_pixel_movement:
			_display.position = round(_display.position)
