extends Node2D

# Ruta a la escena base
const IMAGE_OBJECT_SCENE_PATH = "res://scenes/object_image.tscn"

# Ruta a la carpeta de imágenes
const IMAGE_FOLDER = "res://images/"


func create_image_object(image_object_scene, image_path):
	# Instanciar la escena base
	#print(image_path)
	var image_object = image_object_scene.instantiate()
	if image_object == null:
		print("Error: No se pudo instanciar la escena base.")
		return
	
	if image_object == null:
		print("Error al instanciar la escena base.")
		return

	# Obtener los nodos hijo
	var sprite = image_object.get_node("Sprite2D")
	var collision_shape = image_object.get_node("CollisionShape2D")
	# Configurar la textura del sprite
	var texture = load(image_path)
	#print(image_path)
	#print(sprite.texture)
	sprite.texture = texture
	
	# Configurar la forma de colisión según el tamaño de la imagen
	if texture:
		var shape = RectangleShape2D.new()
		shape.extents = texture.get_size() / 2
		collision_shape.shape = shape

	# Añadir el objeto a la escena principal
	add_child(image_object)
	#print(image_object)



func _ready():
	# Cargar la escena base
	var image_object_scene = ResourceLoader.load(IMAGE_OBJECT_SCENE_PATH)
	
	if image_object_scene == null or !image_object_scene is PackedScene:
		print("Error al cargar la escena base.")
		return

	# Crear una instancia de DirAccess
	var dir = DirAccess.open(IMAGE_FOLDER)
	#var directory_path = 'res://images/'
	#var op = DirAcess.open(IMAGE_FOLDER)
	
	if dir:
		# Comenzar a listar los archivos de la carpeta
		dir.list_dir_begin()
		#print("aaaaaaaaaaaaaaaaa",dir.current_is_dir())
		var file_name = dir.get_next()
		#print(file_name)
		# Iterar sobre todos los archivos de la carpeta
		while file_name != "":
			if !dir.current_is_dir():
				# Crear un objeto para cada imagen
				var image_path = IMAGE_FOLDER + file_name
				#print("lo que seria", image_path)
				print(file_name)
				create_image_object(image_object_scene, "res://images/" + file_name)
			file_name = dir.get_next()
			#print(file_name)
		
		# Finalizar el listado de archivos
		dir.list_dir_end()
	else:
		print("Error al abrir la carpeta de imágenes.")

