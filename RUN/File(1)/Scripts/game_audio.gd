extends Node

@onready var bgm_player = $BGMPlayer

func play_click():
	$ClickSound.play()
#AudioManager.play_click()
#AudioManager.play_pause()

func _ready():
	bgm_player.stream.loop = true
	bgm_player.play()
func play_bgm():
	if not bgm_player.playing:
		bgm_player.play()

func pause_bgm():
	if bgm_player.playing:
		bgm_player.stop()

func is_bgm_playing() -> bool:
	return bgm_player.playing

