--------------------------------------------------------------------------------
-- Inicializar composer
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene()

--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local cce
local cce2
local btComecarJogo
local btCreditos
local comecarJogo = {}
local creditos = {}
local carregarImgMenu = {}
local carregarEfeitoToque = {}
local carregarTextoToque = {}
local carregarCeuEstrelado = {}
local carregarCeuEstrelado2 = {}
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

end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("menu")
  composer.removeScene("jogo")
  composer.removeScene("creditos")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    btComecarJogo:addEventListener("touch", comecarJogo)
    btCreditos:addEventListener("touch", creditos)
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
    -- Chama imediatamente quando a cena está fora da tela
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Chamado quando cena atual é removida
--------------------------------------------------------------------------------
function scene:destroy(event)
  local sceneGroup = self.view

  display.remove(background)
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Cria grupo(s) para unir elementos da tela
--------------------------------------------------------------------------------
function criarGrupos( )
  --grupoMenu = display.newGroup( )
  --scene.view:insert(grupoMenu)
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

  btComecarJogo = display.newText("Começar", display.contentCenterX + 250, display.contentCenterY + 250)
  scene.view:insert(btComecarJogo)

  btCreditos = display.newText("Créditos", display.contentCenterX - 250, display.contentCenterY + 250)
  scene.view:insert(btCreditos)
end
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
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoJogo = {
	effect = "fade", time = 500
}
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoCreditos = {
	effect = "fade", time = 550
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para início do jogo
--------------------------------------------------------------------------------
function comecarJogo( )
  composer.removeScene("submenu")
	composer.gotoScene("jogo", configTransicaoJogo)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena de créditos do jogo
--------------------------------------------------------------------------------
function creditos( )
  composer.removeScene("submenu")
	composer.gotoScene("creditos", configTransicaoCreditos)
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
