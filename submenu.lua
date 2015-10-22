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
local ced
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
local carregarEnredo = {}
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
    --ced = timer.performWithDelay(500, carregarEnredo, 0)
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
  if (cce) then
    timer.cancel(cce)
    cce = nil
  end
  if (cce2) then
    timer.cancel(cce2)
    cce2 = nil
  end
  if (ced) then
    timer.cancel(ced)
    ced = nil
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

  enredo = display.newImageRect("images/enredo.png", display.contentWidth, display.contentHeight)
  enredo.x = display.contentCenterX
  enredo.y = display.contentCenterY + 130
  --enredo.alpha = 0
  scene.view:insert(enredo)

  btComecarJogo = display.newImage("images/botao.png")
  btComecarJogo.x = display.contentCenterX + 235
  btComecarJogo.y = display.contentCenterY + 250
  scene.view:insert(btComecarJogo)

  btCreditos = display.newImage("images/botao.png")
  btCreditos.x = display.contentCenterX - 250
  btCreditos.y = display.contentCenterY + 250
  scene.view:insert(btCreditos)

  comecarTxt = display.newImage("images/comecar.png")
  comecarTxt.x = display.contentCenterX + 242
  comecarTxt.y = display.contentCenterY + 250
  scene.view:insert(comecarTxt)

  creditosTxt = display.newImage("images/creditos.png")
  creditosTxt.x = display.contentCenterX - 242
  creditosTxt.y = display.contentCenterY + 250
  scene.view:insert(creditosTxt)
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
-- Carregar Enredo na tela
--------------------------------------------------------------------------------
function carregarEnredo()
  if (enredo ~= nil) then
    if (enredo.alpha == 0) then
        transition.to(enredo, {time=500, alpha=1})
    end
  end
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
