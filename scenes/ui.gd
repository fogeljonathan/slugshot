extends Control

@onready var lives = 4
@onready var score = 0

var maxshots = 5
@onready var shots = maxshots

func _ready():
	SIGNALS.level_change.connect(_on_level_change)
	SIGNALS.bullet_hits_shaker.connect(_on_bullet_hits_shaker)
	SIGNALS.shaker_hits_player.connect(_on_shaker_hits_player)
	SIGNALS.spawn_bullet.connect(_do_ammo_change)
	SIGNALS.reload_gun.connect(_do_ammo_reload)
	
	var livesleft = ""
	for i in range(1,lives+1) :
		livesleft = livesleft+"\u2764"
	$lives.text =  livesleft

	var shotsleft = ""
	for i in range(1,shots+1) :
		shotsleft = shotsleft+"\u204C"
	$ammo.text =  shotsleft

func _do_ammo_change(spawn_position:Vector2, spawn_rotation:float, spawn_speed:float):
	shots -= 1

	var shotsleft = ""
	for i in range(1,shots+1) :
		shotsleft = shotsleft+"\u204C"
	$ammo.text =  shotsleft
	
func _do_ammo_reload():
	shots = maxshots

	var shotsleft = ""
	for i in range(1,shots+1) :
		shotsleft = shotsleft+"\u204C"
	$ammo.text =  shotsleft
	
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
		
	var livesleft = ""
	for i in range(1,lives) :
		livesleft = livesleft+"\u2764"
	
	$lives.text = prefix + livesleft + suffix
