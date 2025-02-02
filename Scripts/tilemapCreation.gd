extends Node2D

var id_of_current_entity = 0

onready var entity_menu_t = preload("res://Scenes/Pages/EntityMenu/EntityMenu.tscn")

onready var TileMapEditorWindow = $TileMapEditorWindow
onready var TileMapEditorWindow_roomSize = $TileMapEditorWindow/World/roomSize
onready var TileMapEditorWindow_bgA = $TileMapEditorWindow/World/roomSize/bgA
onready var TileMapEditorWindow_bgB = $TileMapEditorWindow/World/roomSize/bgB

var leftContainer
var layer_id: int = 0


var level_count: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	leftContainer = get_tree().get_nodes_in_group("levelContainer")[0]
	var node = leftContainer.get_node("TileMap")
	var tile_ids = node.tile_set.get_tiles_ids()
	for tile_id in tile_ids:
		var texture = node.tile_set.tile_get_texture(tile_id)
		$CanvasLayer/VBoxContainer/ChangeTileMode.add_icon_item(texture, str(tile_id), tile_id)

	#var tile_ids = TileMapEditorWindow_tileMap.tile_set.get_tiles_ids()
	#for tile_id in tile_ids:
	#	var texture = TileMapEditorWindow_tileMap.tile_set.tile_get_texture(tile_id)
	#	$CanvasLayer/VBoxContainer/ChangeTileMode.add_icon_item(texture, str(tile_id), tile_id)
		
	#update_load_image_modes()
	update_change_level_list()

func update_load_image_modes():
	return
	#var load_modes: Array = singleton.get_load_modes()
	#$CanvasLayer/VBoxContainer/HBoxContainer/loadImageOption1.select(load_modes[0])
	#$CanvasLayer/VBoxContainer/HBoxContainer2/loadImageOption2.select(load_modes[1])

func update_change_level_list():
	return
	#$CanvasLayer/VBoxContainer/ChangeCurLevel.clear()
	#level_count = singleton.get_level_count()
	#for cur_level_ind in range(level_count):
	#	$CanvasLayer/VBoxContainer/ChangeCurLevel.add_item("Level_"+str(cur_level_ind), cur_level_ind)

func _process(delta):
	if(Input.is_action_just_pressed("save_project")):
		var texture_size = singleton.get_level_size(singleton.cur_level_ind)
		var collision_map_size = Vector2(texture_size.x/singleton.cell_size, texture_size.y/singleton.cell_size)
		
		#singleton.save_collisionMap(TileMapEditorWindow_tileMap, collision_map_size)
		singleton.save_project()
		

func _on_LoadBackgroundBtn_button_down():
	layer_id = 0
	$CanvasLayer/LoadBGFile.popup_centered()


func _on_LoadBGFile_file_selected(path):
	
	var ext = path.get_extension();
	if(!(ext in ['png', 'bmp'])):
		return
	var localPath = path.replace(ProjectSettings.globalize_path("res://"), "./")
	return
	
	

func _on_GenCodeBtn_button_down():
	$CanvasLayer/VBoxContainer/GenCodeBtn.call("test")


func _on_ChangeTileMode_item_selected(index):
	#pass
	singleton.draw_tile_ind = index


func _on_addNewEntityTypeBtn_button_down():
	#get_tree().change_scene("res://Scenes/Pages/EntityMenu.tscn")
	var inst = entity_menu_t.instance()
	add_child(inst)



func _on_TileMapEditorWindow_mouse_entered():
	print("mouse entered")
	pass # Replace with function body.


func _on_Button_button_down():
	print("test")
	pass # Replace with function body.


func _on_buildProjectBtn_pressed():
	singleton.save_project()
	$CanvasLayer/VBoxContainer/buildProjectBtn.call("buildProject")
	pass # Replace with function body.


func _on_Button_pressed():
	print(singleton.get_merged_varInst_levels())
	pass # Replace with function body.


func _on_addNewLevelBtn_button_down():
	pass # Replace with function body.
	return
	#level_count+=1
	#singleton.add_level()
	#$CanvasLayer/VBoxContainer/ChangeCurLevel.add_item("Level_"+str(level_count-1), level_count-1)
	#get_tree().call_group("tilemapEditorWindow", "load_levels")

func _on_deleteCurLevelBtn_button_down():
	
	update_change_level_list()
	get_tree().call_group("tilemapEditorWindow", "load_level")
	update_load_image_modes()


func _on_ChangeCurLevel_item_selected(index):
	pass # Replace with function body.
	singleton.cur_level_ind = index
	get_tree().call_group("tilemapEditorWindow", "load_level")
	update_load_image_modes()


func _on_LoadBackgroundBtn2_button_down():
	layer_id = 1
	$CanvasLayer/LoadBGFile.popup_centered()


func _on_DeleteBgABtn_button_down():
	TileMapEditorWindow_bgA.texture = null;
	#singleton.change_bgRelPath("");
	pass # Replace with function body.


func _on_DeleteBgBBtn_button_down():
	TileMapEditorWindow_bgB.texture = null;
	#singleton.change_bgRelPath2("");


func _on_snapToGridBtn_toggled(button_pressed):
	singleton.entity_snap_to_grid = button_pressed



func _on_loadImageOption1_item_selected(index):
	pass
	#singleton.change_load_image_mode_bga(index)


func _on_loadImageOption2_item_selected(index):
	pass
	#singleton.change_load_image_mode_bgb(index)


func _on_changebgA4AllLevels_confirmed():
	singleton.change_load_image_mode_bga_all_levels()
	singleton.change_bgRelPath_all_levels()


func _on_changebgB4AllLevels_confirmed():
	singleton.change_load_image_mode_bgb_all_levels()
	singleton.change_bgRelPath2_all_levels()


func _on_changeBGA4AllLevels_button_down():
	$changebgA4AllLevels.popup_centered()


func _on_changeBGB4AllLevels_button_down():
	$changebgB4AllLevels.popup_centered()



