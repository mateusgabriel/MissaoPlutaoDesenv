--------------------------------------------------------------------------------
-- Inicializar composer/physicss
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene( )
local physics = require("physics")
physics.start()
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local cce
local cce2
local creditosTxt
local btRetornarMenu
local retornarSubMenu = {}
local carregarImgsCreditos = {}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImgsCreditos()
  --criarGrupos()

  local somCreditos = audio.loadStream( "sons/credits.ogg" )
  audio.play(somCreditos, {loops = -1, channel = 1, fadein = 2000})
  audio.setVolume( 0.50 , { channel=1 })
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("submenu")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    btRetornarMenu:addEventListener("touch", retornarSubMenu)
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

  audio.stop(1)
  display.remove(background)
  if (cce) then
    timer.cancel(cce)
    cce = nil
  end
  if (cce2) then
    timer.cancel(cce2)
    cce2 = nil
  end
  --display.remove(creditosTxt)
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Cria grupo(s) para unir elementos da tela
--------------------------------------------------------------------------------
function criarGrupos( )
  grupoCreditos = display.newGroup( )
  --scene.view:insert(grupoFoguete)
  scene.view:insert(grupoCreditos)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar imagens contidas no menu
--------------------------------------------------------------------------------
function carregarImgsCreditos( )
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

  creditosTxt = display.newText("Créditos", display.contentWidth, display.contentHeight, "Visitor TT1 BRK", 80)
  creditosTxt.x = display.contentCenterX
  creditosTxt.y = display.contentCenterY - 230
  scene.view:insert(creditosTxt)

  displayCreditos = display.newImage("images/displayCreditos.png", display.contentWidth, display.contentHeight)
  displayCreditos.x = display.contentCenterX + 10
  displayCreditos.y = display.contentCenterY + 70
  scene.view:insert(displayCreditos)

  btRetornarMenu = display.newImage("images/botaoRetornaMenu.png", display.contentWidth, display.contentHeight)
  btRetornarMenu.x = display.contentCenterX - 380
  btRetornarMenu.y = display.contentCenterY + 235
  scene.view:insert(btRetornarMenu)
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
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoSubMenu = {
	effect = "fade", time = 550
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para retorno ao jogo
--------------------------------------------------------------------------------
function retornarSubMenu( )
  composer.removeScene("creditos")
	composer.gotoScene("submenu", configTransicaoSubMenu)
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
