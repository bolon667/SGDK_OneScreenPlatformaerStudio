extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var prevProjectBtn_t = preload("res://Scenes/startWindow/prevProjectButton.tscn")

onready var prevProjectsContainer = $"VBoxContainer/HBoxContainer/Control/ListContainer/HBoxContainer/ScrollContainer/prevProjectsContainer"
var cur_path:String = ProjectSettings.globalize_path("res://") + "StudioType/SGDK/Projects/"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	$loadProjectDialog.current_path = cur_path
	load_project_last_paths(singleton.load_project_last_paths())

func load_prev_project(project_name: String):
	singleton.cur_project_folder_path = cur_path + project_name 
	singleton.cur_project_path =  cur_path + project_name + "/data.json"
	singleton.load_project(singleton.cur_project_path)
	get_tree().change_scene("res://Scenes/mapEditorScene.tscn")

func load_project_last_paths(dict):
	for path in dict["last_project_paths"]:
		var btn_node = prevProjectBtn_t.instance()
		btn_node.text = path
		prevProjectsContainer.add_child(btn_node)
	

func _on_NewProjBtn_button_down():
	$createProjectDialog.popup_centered()


func _on_createProjectDialog_file_selected(path):
	singleton.cur_project_path = path
	singleton.save_project()
	singleton.save_project_last_paths()
	
	get_tree().change_scene("res://Scenes/mapEditorScene.tscn")


func _on_LoadProjBtn_button_down():
	$loadProjectDialog.popup_centered()
	

func _on_loadProjectDialog_dir_selected(dir):
	var data_path: String = dir + "/data.json"
	singleton.cur_project_folder_path = str(dir)
	singleton.cur_project_path = data_path
	
	
	singleton.load_project(data_path)
	singleton.save_project_last_paths()
	
	get_tree().change_scene("res://Scenes/mapEditorScene.tscn")
