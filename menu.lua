--------------------------------------------------------------------------------
-- Inicializar composer
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene()

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local cet
local cce
local cce2
local toqueTxt
local teste
local carregarImgMenu = {}
local carregarEfeitoToque = {}
local carregarTextoToque = {}
local carregarCeuEstrelado = {}
local carregarCeuEstrelado2 = {}
local carregarSubMenu = {}
local criarGrupos = {}
local toqueParaComecar = {}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImgsMenu()
  criarGrupos()
  carregarTextoToque()

end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("submenu")
  composer.removeScene("creditos")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    cet = timer.performWithDelay(800, carregarEfeitoToque, 0)
    cce = timer.performWithDelay(1000, carregarCeuEstrelado, 0)
    cce2 = timer.performWithDelay(1500, carregarCeuEstrelado2, 0)
    background:addEventListener("touch", carregarSubMenu)
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
  if (cet) then
    timer.cancel(cet)
    cet = nil
  end
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Cria grupo(s) para unir elementos da tela
--------------------------------------------------------------------------------
function criarGrupos( )
  grupoMenu = display.newGroup( )
  scene.view:insert(grupoMenu)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar imagens contidas no menu
--------------------------------------------------------------------------------
function carregarImgsMenu( )
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

  --options = { width = 72, height = 72, numFrames = 19}
  --playerSheet = graphics.newImageSheet( "images/asteroid5.png", options )
  --sequenceData = {
  --  { name = "rotacao", start = 1, count = 19 , time = 5000, loopCount = 0}
  --}
  --teste = display.newSprite( playerSheet, sequenceData )
  teste = display.newCircle(250, 250, 130);
  teste.x = display.contentCenterX
  teste.y = display.contentCenterY - 50
  teste.alpha = 0.75
  --teste:play()
  scene.view:insert(teste)

  logomarca = display.newImage("images/logomarcaTeste.png")
  logomarca.x = display.contentCenterX
  logomarca.y = display.contentCenterY + 140
  scene.view:insert(logomarca)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar texto de "Toque para iniciar"
--------------------------------------------------------------------------------
function carregarTextoToque()
 toqueTxt = display.newImage("images/toqueParaIniciar.png")
 toqueTxt.x = display.contentCenterX
 toqueTxt.y = display.contentCenterY + 270
 toqueTxt.alpha = 0
 scene.view:insert(toqueTxt)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar efeito de texto de "Toque para iniciar"
--------------------------------------------------------------------------------
function carregarEfeitoToque()
  if (toqueTxt ~= nil) then
    if (toqueTxt.alpha > 0) then
        transition.to(toqueTxt, {time=100, alpha=0})
    else
        transition.to(toqueTxt, {time=100, alpha=1})
    end
  end
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
	effect = "fade", time = 1000
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena de submenu do jogo
--------------------------------------------------------------------------------
function carregarSubMenu( )
  composer.removeScene("menu")
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
