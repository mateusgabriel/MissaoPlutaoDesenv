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
local cce
local cce2
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

  resultadoFinalTxt = display.newText('Resultado Final  ' .. resultadoFinal, display.contentCenterX, display.contentCenterY + 100, native.systemFontBold, 20)
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
    cce = timer.performWithDelay(1000, carregarCeuEstrelado, 0)
    cce2 = timer.performWithDelay(1500, carregarCeuEstrelado2, 0)
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
  if (cce) then
    timer.cancel(cce)
    cce = nil
  end
  if (cce2) then
    timer.cancel(cce2)
    cce2 = nil
  end
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

  ceuEstrelado = display.newImageRect("images/ceuEstrelado.png", display.contentWidth, display.contentHeight)
  ceuEstrelado.x = display.contentCenterX
  ceuEstrelado.y = display.contentCenterY
  ceuEstrelado.alpha = 0
  scene.view:insert(ceuEstrelado)

  ceuEstrelado2 = display.newImageRect("images/ceuEstrelado2.png", display.contentWidth, display.contentHeight)
  ceuEstrelado2.x = display.contentCenterX
  ceuEstrelado2.y = display.contentCenterY
  ceuEstrelado2.alpha = 0
  scene.view:insert(ceuEstrelado2)

  gameOverTxt = display.newText("Game Over", display.contentCenterX, display.contentCenterY - 90, native.systemFontBold, 50)
  scene.view:insert(gameOverTxt)

  btRetornarJogo = display.newImage("images/botao.png")
  btRetornarJogo.x = display.contentCenterX - 250
  btRetornarJogo.y = display.contentCenterY + 250
  scene.view:insert(btRetornarJogo)

  btRetornarMenu = display.newImage("images/botao.png")
  btRetornarMenu.x = display.contentCenterX + 250
  btRetornarMenu.y = display.contentCenterY + 250
  scene.view:insert(btRetornarMenu)

  retornarJogoTxt = display.newImage("images/jogarDeNovo.png")
  retornarJogoTxt.x = display.contentCenterX - 240
  retornarJogoTxt.y = display.contentCenterY + 250
  scene.view:insert(retornarJogoTxt)

  retornarMenuTxt = display.newImage("images/menu.png")
  retornarMenuTxt.x = display.contentCenterX + 250
  retornarMenuTxt.y = display.contentCenterY + 250
  scene.view:insert(retornarMenuTxt)

  combustivelConsumidoTxt = display.newText('Combustível Restante  ' .. combustivel, display.contentCenterX, display.contentCenterY + 40, native.systemFontBold, 20)
  scene.view:insert(combustivelConsumidoTxt)

  distanciaPercorridaTxt = display.newText('Distância Percorrida  ' .. distancia, display.contentCenterX, display.contentCenterY + 60, native.systemFontBold, 20)
  scene.view:insert(distanciaPercorridaTxt)

  pontosGanhosTxt = display.newText('Pontos Obtidos  ' .. pontos, display.contentCenterX, display.contentCenterY + 80, native.systemFontBold, 20)
  scene.view:insert(pontosGanhosTxt)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar background com estrelas brilhando
--------------------------------------------------------------------------------
function carregarCeuEstrelado()
  if (ceuEstrelado ~= nil) then
    if (ceuEstrelado.alpha > 0) then
        transition.to(ceuEstrelado, {time=1200, alpha=0})
    else
        transition.to(ceuEstrelado, {time=1200, alpha=1})
    end
  end
end

function carregarCeuEstrelado2()
  if (ceuEstrelado2 ~= nil) then
    if (ceuEstrelado2.alpha > 0) then
        transition.to(ceuEstrelado2, {time=1500, alpha=0})
    else
        transition.to(ceuEstrelado2, {time=1500, alpha=1})
    end
  end
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
local configTransicaoJogoSubMenu = {
	effect = "fade", time = 500
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para retorno ao jogo
--------------------------------------------------------------------------------
function retornarJogo( )
  composer.removeScene("gameOver")
	composer.gotoScene("jogo", configTransicaoJogoSubMenu)
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
	composer.gotoScene("submenu", configTransicaoJogoSubMenu)
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
