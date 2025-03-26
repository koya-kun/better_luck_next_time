extends Node

var sound_level : float = 0
var music_level : float = 0
var current_color_theme : Array[Color]

var music_player : AudioStreamPlayer

func enter_menu():
	pass
	#GameManager.processmode = Processmode.disabled

func exit_menu():
	pass
	#GameManager.processmode = Processmode.enabled

func play_sound(sound):
	var player : AudioStreamPlayer = AudioStreamPlayer.new()
	player.stream = sound
	await player.finished
	player.queue_free()

func play_soundtrack():
	var player : AudioStreamPlayer = AudioStreamPlayer.new()
	self.add_child(player)
	#player.stream = soundtrack
	player.play()
