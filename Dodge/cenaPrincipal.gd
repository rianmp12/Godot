extends Node


export (PackedScene) var Inimigo
var pontos 


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	novo_jogo()


func game_over():
	$pontuacaoTimer.stop()
	$inimigoTimer.stop()
	$HUD.exibir_game_over()
	$musica.stop()
	$somMorte.play()


func novo_jogo():
	pontos = 0
	$jogador.start($posicaoInicial.position)
	$inicioTimer.start()
	$HUD.exibir_mensagem("Prepare-se")
	$HUD.atualiza_score(pontos)
	$musica.play()


func _on_inicioTimer_timeout():
	$pontuacaoTimer.start()
	$inimigoTimer.start()


func _on_pontuacaoTimer_timeout():
	pontos += 1
	$HUD.atualiza_score(pontos)


func _on_inimigoTimer_timeout():
	$caminhoInimigo/spawnInimigo.offset = randi()
	var inimigo = Inimigo.instance()
	add_child(inimigo)
	var direcao = $caminhoInimigo/spawnInimigo.rotation + PI/2
	inimigo.position = $caminhoInimigo/spawnInimigo.position
	direcao += rand_range(-PI/4, PI/4)
	inimigo.rotation - direcao
	inimigo.linear_velocity = Vector2(rand_range(inimigo.min_speed, inimigo.max_speed),0)
	inimigo.linear_velocity = inimigo.linear_velocity.rotated(direcao)
