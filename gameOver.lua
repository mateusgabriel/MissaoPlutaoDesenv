--------------------------------------------------------------------------------
-- Inicializar composer/physicss
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
physics.setDrawMode("hybrid")
physics.start()
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local gameOverTxt
local btRetornarJogo
local btRetornarMenu
local distanciaPercorridaTxt
local combustivelConsumidoTxt
local pontosGanhosTxt
local resultadoFinal
local resultadoFinalTxt
local adicionarResultadoFinal = {}
local calcularResultadoFinal = {}
local carregarImgsGameOver = {}
local criarGrupos = {}
local retornarJogo = {}
local retornarMenu = {}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImgsGameOver()
  calcularResultadoFinal()
  criarGrupos()

  resultadoFinalTxt = display.newText('Resultado Final  ' .. resultadoFinal, display.contentCenterX, display.contentCenterY + 160, native.systemFontBold, 20)
  scene.view:insert(resultadoFinalTxt)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("jogo")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    btRetornarJogo:addEventListener("touch", retornarJogo)
    btRetornarMenu:addEventListener("touch", retornarMenu)
    -- Chama quando a cena está na tela
    -- Inserir código para fazer que a cena venha "viva"
    -- Ex: start times, begin animation, play audio, etc
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:hide
--------------------------------------------------------------------------------
function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está na cena
    -- Inserir código para "pausar" a cena
    -- Ex: stop timers, stop animation, stop audio, etc
  elseif (phase == "did") then
    --gameOver()
    -- Chama imediatamente quando a cena está fora da tela
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:destroy
--------------------------------------------------------------------------------
function scene:destroy(event)
  local sceneGroup = self.view

  display.remove(background)
  --display.remove(gameOverTxt)
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Cria grupo(s) para unir elementos da tela
--------------------------------------------------------------------------------
function criarGrupos( )
  grupoGameOver = display.newGroup( )
  --scene.view:insert(grupoFoguete)
  scene.view:insert(grupoGameOver)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar imagens contidas no menu
--------------------------------------------------------------------------------
function carregarImgsGameOver( )
  background = display.newImageRect("images/ceu.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  scene.view:insert(background)

  gameOverTxt = display.newText("Game Over", display.contentCenterX, display.contentCenterY - 90, native.systemFontBold, 50)
  scene.view:insert(gameOverTxt)

  btRetornarJogo = display.newText("Retornar ao jogo", display.contentCenterX, display.contentCenterY)
  scene.view:insert(btRetornarJogo)

  btRetornarMenu = display.newText("Retornar ao menu", display.contentCenterX, display.contentCenterY + 50)
  scene.view:insert(btRetornarMenu)

  combustivelConsumidoTxt = display.newText('Combustível Restante  ' .. combustivel, display.contentCenterX, display.contentCenterY + 100, native.systemFontBold, 20)
  scene.view:insert(combustivelConsumidoTxt)

  distanciaPercorridaTxt = display.newText('Distância Percorrida  ' .. distancia, display.contentCenterX, display.contentCenterY + 120, native.systemFontBold, 20)
  scene.view:insert(distanciaPercorridaTxt)

  pontosGanhosTxt = display.newText('Pontos Obtidos  ' .. pontos, display.contentCenterX, display.contentCenterY + 140, native.systemFontBold, 20)
  scene.view:insert(pontosGanhosTxt)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Calcula o resultado final com bases nos valores globais de distância e pontos
--------------------------------------------------------------------------------
function calcularResultadoFinal()
  if (pontos == 0 or pontos == 1) then
    resultadoFinal = distancia
  else
    resultadoFinal = distancia * pontos
  end
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoJogoMenu = {
	effect = "fade", time = 1000
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para retorno ao jogo
--------------------------------------------------------------------------------
function retornarJogo( )
  composer.removeScene("gameOver")
	composer.gotoScene("jogo", configTransicaoJogoMenu)
  distancia = 0
  distanciaAux = 250
  combustivel = 1000
  pontos = 0
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para retorno ao jogo
--------------------------------------------------------------------------------
function retornarMenu( )
  composer.removeScene("gameOver")
	composer.gotoScene("menu", configTransicaoJogoMenu)
  distancia = 0
  distanciaAux = 250
  combustivel = 1000
  pontos = 0
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Listener Setup
--------------------------------------------------------------------------------
scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)
--------------------------------------------------------------------------------

return scene
