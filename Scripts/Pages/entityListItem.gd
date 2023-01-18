extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_DeleteBtn_button_down():
	$ConfirmationDialogDelete.popup_centered()
	


func _on_ConfirmationDialogDelete_confirmed():
	singleton.cur_entity_type_ind = get_index()
	singleton.delete_entityDef($HBoxContainer/TextBtn.text)
	#print(singleton.entity_types)
	get_tree().call_group("entityMenu", "clear_entity_fields")
	get_tree().call_group("entityMenu", "clear_field_properties")
	
	get_tree().call_group("entityMenu", "get_entity_list")
	queue_free()


func _on_TextBtn_button_down():
	singleton.cur_entity_type_ind = get_index()
	singleton.cur_entity_field_ind = 0
	singleton.cur_entity_type = $HBoxContainer/TextBtn.text
	get_tree().call_group("entityMenu", "clear_field_properties")
	get_tree().call_group("entityMenu", "load_entity_fields")
	get_tree().call_group("entityMenu", "load_entity_pic")
	
	
	
	
	
	
