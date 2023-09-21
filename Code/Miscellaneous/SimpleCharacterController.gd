extends CharacterBody3D
@export var camera: Camera3D
@export var speed: float = 3

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
    #Get the forward and right vectors of the camera
    var forward = camera.global_transform.basis.z
    forward.y = 0
    var right = camera.global_transform.basis.x
    right.y = 0
   
    #Get the input
    var input:Vector2 = Input.get_vector("left","right","forwards","backwards")
    var direction:Vector3 = Vector3(input.x,0,input.y)

    #Make direction relative to the camera
    direction = forward * direction.z + right * direction.x
    direction = direction.normalized()

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y += 5

    #Set velocity and move
    velocity = Vector3(
                    direction.x * speed,
                    velocity.y - gravity * delta,
                    direction.z * speed
                )

    #Jump when space is pressed


    move_and_slide()     

