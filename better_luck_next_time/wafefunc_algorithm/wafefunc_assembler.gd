extends Node2D
class_name Cell_assembler


@export var grid_width:int = 10
@export var grid_height:int  = 10



enum TYPE  {WALL,AIR,PATH}
var cell_scenes: Array[Resource]

var cell_freedoms : Array[Dictionary]

var vgrid:virtual_grid 


func _ready() -> void:
	vgrid = virtual_grid.new(grid_width,grid_height)
			
		
	
	
	
	
	
	
	for path_to_scene in ResourceLoader.list_directory("res://wafefunc_algorithm/cells/"):
		cell_scenes.append(load(path_to_scene))
	
	var init_cells: Array[Cell]
	for loaded_scene in cell_scenes:
		init_cells.append(loaded_scene.instantiate())
	
	for cell in init_cells:
		cell_freedoms.append(
			{
				"up": cell.up,
				"down": cell.down,
				"left": cell.left,
				"right": cell.rigth		
			}		
		)



func check_vgrid() -> bool:
	return true


class virtuel_cell:
	enum STATE  {EMPTY,}
	
class virtual_grid:
	var grid : Array[Array]
	func _init(width, height) -> void:
		for horizontal in range(width):
			var new_column = []
		
			for vertical in range(height):
				var new_vcell = virtuel_cell.new()
				new_column.append(new_vcell)
		
			grid.append(new_column)
			
		
		
