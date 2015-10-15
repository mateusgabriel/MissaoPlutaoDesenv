--------------------------------------------------------------------------------
-- Inicializar composer/physicss
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")
physics.setDrawMode("hybrid")
physics.start()
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local cometa
local foguete
local grupoCombComet
local grupoFoguete
local speed = 8000
local speedEstrelas = 2
local cac -- recebe a criação(carregar) de cometas
local add -- recebe o incrementador(adicionar) da distância
local pcp -- receber f decrementador de combustível e pontos
local coc -- recebe a criação do objeto combustível
local adp -- recebe o incrementador(adicionar) de pontos
local adc -- recebe o incrementador(adicionar) do combustível
local distanciaTxt
local combustivelTxt
local pontosTxt
local carregarImgsJogo = {}
local carregarFoguete = {}
local carregarCometas = {}
local carregarObjCombustivel = {}
local adicionarDistancia = {}
local adicionarCombustivel = {}
local adicionarPontos = {}
local adicionarDisplayDCP = {}
local controlarFoguete = {}
local criarGrupos = {}
local gameOver = {}
local perderCP = {}
local ganharCP = {}
local scrollEstrelas = {}
local perderCombustivelPontosPorDistancia = {}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Inicia a cena aqui
-- Ex:adicionar objetos display para "sceneGroup", adicionar touch Listeners,etc
--------------------------------------------------------------------------------
function scene:create(event)
  local sceneGroup = self.view
  carregarImgsJogo()
  carregarFoguete()
  adicionarDisplayDCP()
  criarGrupos()

end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:show
--------------------------------------------------------------------------------
function scene:show(event)
  local sceneGroup = self.view
  local phase = event.phase

  composer.removeScene("gameOver")

  if (phase == "will") then
    -- Chama quando a cena está fora da tela
  elseif (phase == "did") then
    coc = timer.performWithDelay( 5000, carregarObjCombustivel, 0 )
    cac = timer.performWithDelay( 1800, carregarCometas, 0 )
    add = timer.performWithDelay( 1000, adicionarDistancia, 0 )
    adc = timer.performWithDelay( 1000, adicionarCombustivel, 0 )
    adp = timer.performWithDelay( 1000, adicionarPontos, 0 )
    pcp = timer.performWithDelay( 1005, perderCombustivelPontosPorDistancia, 0 )
    Runtime:addEventListener("touch", controlarFoguete)
    Runtime:addEventListener("collision", onLocalCollision)
    Runtime:addEventListener("enterFrame", scrollEstrelas)
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
    --background:addEventListener("touch", controlarFoguete)
    -- Chama quando a cena está na tela
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

  Runtime:removeEventListener("collision", onLocalCollision)
  Runtime:removeEventListener("touch", controlarFoguete)
  Runtime:removeEventListener("enterFrame", scrollEstrelas)
  display.remove(grupoCombComet)
  display.remove(teto1)
  display.remove(teto2)
  display.remove(teto3)
  display.remove(foguete)
  display.remove(chao)
  display.remove(background)
  if (coc) then
    timer.cancel(coc)
    coc = nil
  end
  if (cac) then
    timer.cancel(cac)
    cac = nil
  end
  if (add) then
    timer.cancel(add)
    add = nil
  end
  if (adc) then
    timer.cancel(adc)
    adc = nil
  end
  if (adp) then
    timer.cancel(adp)
    adp = nil
  end
  if (pcp) then
    timer.cancel(pcp)
    pcp = nil
  end
  --composer.removeScene( "jogo" )
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Cria grupo(s) para unir elementos da tela
--------------------------------------------------------------------------------
function criarGrupos( )
  --grupoFoguete = display.newGroup( )
  grupoCombComet = display.newGroup( )
  --scene.view:insert(grupoFoguete)
  scene.view:insert(grupoCombComet)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar imagens contidas no menu
--------------------------------------------------------------------------------
function carregarImgsJogo( )
  background = display.newImageRect("images/ceu.png", display.contentWidth, display.contentHeight)
  background.x = display.contentCenterX
  background.y = display.contentCenterY
  scene.view:insert(background)

  estrelas1 = display.newImageRect("images/estrelas.png", display.contentWidth, display.contentHeight)
  estrelas1.x = display.contentCenterX
  estrelas1.y = display.contentCenterY
  scene.view:insert(estrelas1)

  estrelas2 = display.newImageRect("images/estrelas.png", display.contentWidth, display.contentHeight)
  estrelas2.x = estrelas1.x + display.contentWidth
  estrelas2.y = display.contentCenterY
  scene.view:insert(estrelas2)

  estrelas3 = display.newImageRect("images/estrelas.png", display.contentWidth, display.contentHeight)
  estrelas3.x = estrelas2.x + display.contentWidth
  estrelas3.y = display.contentCenterY
  scene.view:insert(estrelas3)

  teto1 = display.newImage("images/metero.png")
  teto1.x = 0
  teto1.y = -110
  teto1.name = 'teto'
  physics.addBody(teto1, "static")
  scene.view:insert(teto1)

  teto2 = display.newImage("images/metero.png")
  teto2.x = 410
  teto2.y = -110
  teto2.name = 'teto'
  physics.addBody(teto2, "static")
  scene.view:insert(teto2)

  teto3 = display.newImage("images/metero.png")
  teto3.x = 1900
  teto3.y = -110
  teto3.name = 'teto'
  physics.addBody(teto3, "static")
  scene.view:insert(teto3)

  chao = display.newImageRect("images/chao.png", display.contentWidth, display.contentHeight)
  chao.x = display.contentCenterX
  chao.y = display.contentCenterY + 740
  chao.name = 'chao'
  physics.addBody(chao, "static")
  scene.view:insert(chao)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar foguete
--------------------------------------------------------------------------------
function carregarFoguete()
  foguete = display.newImage("images/nave.png")
  foguete.x = 100
  foguete.y = 200
  foguete.name = 'foguete'
  foguete.isSensor = true;
  physics.addBody(foguete, "dynamic")
  scene.view:insert(foguete)
  --grupoFoguete:insert(foguete)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar foguete
--------------------------------------------------------------------------------
function carregarCometas()
  cometa = display.newImage("images/cometaAzul.png")
  cometa.x = display.contentWidth + 150
  cometa.y = math.random(25, display.contentHeight - 50 )
  cometa.name = 'cometa'
  cometa.isFixedRotation = true
  cometa.isSensor = true
  physics.addBody(cometa, "dynamic")
  transition.to( cometa, {time = speed, x = -400, y = cometa.y})
  grupoCombComet:insert(cometa)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar objeto combustível
--------------------------------------------------------------------------------
function carregarObjCombustivel()
  objCombustivel = display.newImage("images/cuboEnergia.png")
  objCombustivel.x = display.contentWidth + 150
  objCombustivel.y = math.random(25, display.contentHeight - 50 )
  objCombustivel.name = 'combustivel'
  physics.addBody( objCombustivel, "dynamic" )
  objCombustivel.isSensor = true
  transition.to( objCombustivel, {time = speed, x = -50, y = objCombustivel.y})
  grupoCombComet:insert(objCombustivel)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar display DCP(Distância, Combustível, Pontos)
--------------------------------------------------------------------------------
function adicionarDisplayDCP()
  distanciaTxt = display.newText("Distância 0 km", display.contentCenterX - 213, display.contentCenterY + 280, native.systemFontBold, 20)
  scene.view:insert(distanciaTxt)
  combustivelTxt = display.newText("Combustível 0 mil/l", display.contentCenterX + 10, display.contentCenterY + 280, native.systemFontBold, 20)
  scene.view:insert(combustivelTxt)
  pontosTxt = display.newText("0 Pontos", display.contentCenterX - (-190), display.contentCenterY + 280, native.systemFontBold, 20)
  scene.view:insert(pontosTxt)
end


--------------------------------------------------------------------------------
-- Adicionar distância percorrida
--------------------------------------------------------------------------------
function adicionarDistancia()
    distancia = distancia + 5
    distanciaTxt.text = string.format("Distância %d km", distancia)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar combustível
--------------------------------------------------------------------------------
function adicionarCombustivel()
  combustivelTxt.text = string.format("Combustível %d mil/l", combustivel)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar pontos
--------------------------------------------------------------------------------
function adicionarPontos()
  pontosTxt.text = string.format("%d Pontos", pontos)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Ativa o foguete ao clique aplicando força física
--------------------------------------------------------------------------------
function ativarFoguete(self, event)
    self:applyForce(0, -2, self.x, self.y)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Controla o foguete evitando colisões
--------------------------------------------------------------------------------
function controlarFoguete(event)
  -- Ao clicar na tela é aplicada força na nave
  if (event.phase == "began") then
    foguete.enterFrame = ativarFoguete
    Runtime:addEventListener("enterFrame", foguete)
  end
  -- No fim do clique a força aplicada a nave é removida
  if (event.phase == "ended") then
      Runtime:removeEventListener("enterFrame", foguete)
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Verifica as colisões ocorridas durante a execução do programa
--------------------------------------------------------------------------------
function onLocalCollision(event)
	if (event.phase == "began") then
    if (event.object1.name == "foguete" and event.object2.name == "combustivel") then
		    event.object2:removeSelf()
        ganharCP()
    end
    if (event.object1.name == "foguete" and event.object2.name == "cometa") then
		    event.object1:removeSelf()
        gameOver()
    end
    if (event.object1.name == "cometa" and event.object2.name == "foguete") then
        event.object2:removeSelf()
        gameOver()
    end
    if (event.object1.name == "foguete" and event.object2.name == "teto") then
		    event.object1:removeSelf()
        gameOver()
    end
    if (event.object1.name == "teto" and event.object2.name == "foguete") then
        event.object2:removeSelf()
        gameOver()
    end
    if (event.object1.name == "foguete" and event.object2.name == "chao") then
		    event.object1:removeSelf()
        print('passou!')
        gameOver()
    end
    if (event.object1.name == "chao" and event.object2.name == "foguete") then
		    event.object2:removeSelf()
        print('passou tb!')
        gameOver()
    end
    if (event.object1.name == "teto" and event.object2.name == "cometa") then
      event.object2:removeSelf()
    end
    if (event.object1.name == "teto" and event.object2.name == "combustivel") then
      event.object2:removeSelf()
    elseif (event.object1.name == "combustivel" and event.object2.name == "teto") then
        event.object1:removeSelf()
    end
    if (event.object1.name == "chao" and event.object2.name == "cometa") then
      event.object2:removeSelf()
    end
    if (event.object1.name == "chao" and event.object2.name == "combustivel") then
      event.object2:removeSelf()
    end
	end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Realiza cálculo de incremento de combustível e de pontos de acordo com a distância percorrida
--------------------------------------------------------------------------------
function ganharCP ()
  combustivel = combustivel + 50
  pontos = pontos + 2
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Realiza cálculo de decremento de combustível e de pontos de acordo com a distância percorrida
--------------------------------------------------------------------------------
  function perderCP ()
    combustivel = combustivel - 100
  end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- A cada 500km percorridos serão decrementados combustível e pontos do jogador
--------------------------------------------------------------------------------
function perderCombustivelPontosPorDistancia()
  if (distancia == distanciaAux) then
    perderCP()
    distanciaAux = distanciaAux + 250
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scroll das estrelas
--------------------------------------------------------------------------------
function scrollEstrelas (event)
  estrelas1.x = estrelas1.x - speedEstrelas
  estrelas2.x = estrelas2.x - speedEstrelas
  estrelas3.x = estrelas3.x - speedEstrelas

  if (estrelas1.x + estrelas1.contentWidth) < 0 then
    estrelas1:translate( display.contentWidth * 3, 0 )
  end
  if (estrelas2.x + estrelas2.contentWidth) < 0 then
    estrelas2:translate( display.contentWidth * 3, 0 )
  end
  if (estrelas3.x + estrelas3.contentWidth) < 0 then
    estrelas3:translate( display.contentWidth * 3, 0 )
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Configuração de transição entre cenas
--------------------------------------------------------------------------------
local configTransicaoGameOver = {
	effect = "fade", time = 1000
}
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Função que chama cena para início do jogo
--------------------------------------------------------------------------------
function gameOver()
  composer.removeScene("jogo")
  composer.gotoScene("gameOver", configTransicaoGameOver)
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
