extends CanvasLayer

signal start_game

func exibir_mensagem(text):
	$Message_Label.text = text
	$Message_Label.show()
	$MsgTimer.start()


func exibir_game_over():
	exibir_mensagem("Fim de Jogo!")
	yield($MsgTimer,"timeout")
	
	$Message_Label.text = "Desvie e sobreviva aos monstros!"
	$Message_Label.show()
	yield(get_tree().create_timer(1), "timeout")
	$Start_Button.show()


func atualiza_score(score):
	$pontuacao.text = str(score)
	




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.




func _on_Start_Button_pressed():
	$Start_Button.hide()
	emit_signal("start_game")


func _on_MsgTimer_timeout():
	$Message_Label.hide()
