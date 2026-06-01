extends Control

@onready var lives = 3
@onready var score = 0

func _ready():
	SIGNALS.level_change.connect(_on_level_change)
	SIGNALS.bullet_hits_shaker.connect(_on_bullet_hits_shaker)
	SIGNALS.shaker_hits_player.connect(_on_shaker_hits_player)

func _on_level_change(new_level):
	var prefix = ""
	var suffix = ""
	if new_level > 5:
		prefix = prefix + "[pulse]"
		suffix = "[/pulse]" + suffix
	
	if new_level > 10:
		prefix = prefix + "[wave]"
		suffix = "[/wave]" + suffix
	
	if new_level > 15:
		prefix = prefix + "[rainbow]"
		suffix = "[/rainbow]" + suffix
		
	if new_level > 15:
		prefix = prefix + "[shake]"
		suffix = "[/shake]" + suffix
		
	$level.text = "Level " + prefix + str(new_level) + suffix
	
func _on_bullet_hits_shaker():
	score += 1
	var prefix = ""
	var suffix = ""
	if score > 10:
		prefix = prefix + "[pulse]"
		suffix = "[/pulse]" + suffix
	
	if score > 20:
		prefix = prefix + "[wave]"
		suffix = "[/wave]" + suffix
	
	if score > 30:
		prefix = prefix + "[rainbow]"
		suffix = "[/rainbow]" + suffix
		
	if score > 40:
		prefix = prefix + "[shake]"
		suffix = "[/shake]" + suffix
		
	$score.text = "Score: " + prefix + str(score) + suffix
	

func _on_shaker_hits_player():
	lives -= 1
	var prefix = ""
	var suffix = ""
	
	if lives < 2:
		prefix = prefix + "[shake]"
		suffix = "[/shake]" + suffix
		
	$lives.text = prefix + str(lives) + suffix + "/3 Lives"
