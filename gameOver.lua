--------------------------------------------------------------------------------
-- Inicializar composer/physicss
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
-- physics.setDrawMode("hybrid")
physics.start()
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local btRetornarJogo
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
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImgsGameOver()
  calcularResultadoFinal()

  resultadoFinalTxt = display.newText('' .. resultadoFinal, _W2 - 25, _H2 + 90, native.systemFontBold, 20)
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
    btRetornarJogo:addEventListener("touch", retornarJogo)
    -- Chama imediatamente quando a cena está fora da tela
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:destroy
--------------------------------------------------------------------------------
function scene:destroy(event)
  local sceneGroup = self.view
  --composer.removeScene("gameOver")
  --btRetornarJogo:removeEventListener("tap", retornarJogo)
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar imagens contidas no menu
--------------------------------------------------------------------------------
function carregarImgsGameOver( )
  background = display.newImage("images/ceu.fw.png")
  background.x = display.contentWidth / 2
  background.y = display.contentHeight / 2
  scene.view:insert(background)

  btRetornarJogo = display.newText("Clique para retornar", 0, 0)
  btRetornarJogo.x = _W2
  btRetornarJogo.y = _H2
  scene.view:insert(btRetornarJogo)

  combustivelConsumidoTxt = display.newText('' .. combustivel, _W2 - 25, _H2 + 30, native.systemFontBold, 20)
  scene.view:insert(combustivelConsumidoTxt)

  distanciaPercorridaTxt = display.newText('' .. distancia, _W2 - 25, _H2 + 50, native.systemFontBold, 20)
  scene.view:insert(distanciaPercorridaTxt)

  pontosGanhosTxt = display.newText('' .. pontos, _W2 - 25, _H2 + 70, native.systemFontBold, 20)
  scene.view:insert(pontosGanhosTxt)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Calcula o resultado final com bases nos valores globais de distância e pontos
--------------------------------------------------------------------------------
function calcularResultadoFinal()
  resultadoFinal = distancia * pontos
end
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoJogo = {
	effect = "fade", time = 500
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para retorno ao jogo
--------------------------------------------------------------------------------
function retornarJogo( )
  composer.removeScene("gameOver")
	composer.gotoScene("jogo", configTransicaoJogo)
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
