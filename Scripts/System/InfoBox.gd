extends Control

@onready var _fps_label: RichTextLabel = $Panel/FpsLabel


func _process(_delta):
	var fps = Engine.get_frames_per_second()
	var text = ""

	if fps < SystemGlobals.TARGET_FPS / 2:
		text = "[color=#" + Color.DARK_RED.to_html() + "]"
	elif fps < SystemGlobals.TARGET_FPS / 1.5:
		text = "[color=#" + Color.DARK_KHAKI.to_html() + "]"
	else:
		text = "[color=#" + Color.WHITE.to_html() + "]"

	text += str(fps) + " fps[/color]"

	_fps_label.text = text
