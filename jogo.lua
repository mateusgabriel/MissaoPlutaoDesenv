--------------------------------------------------------------------------------
-- Inicializar composer/physicss
--------------------------------------------------------------------------------
local composer = require("composer")
local scene = composer.newScene()
local physics = require("physics")
--physics.setDrawMode("hybrid")
physics.start()
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Declarar/Inicializar variáveis/funções
--------------------------------------------------------------------------------
local ccd -- recebe a criação(carregar) de cometas
local cad
local add -- recebe o incrementador(adicionar) da distância
local pcp -- receber f decrementador de combustível e pontos
local coc -- recebe a criação do objeto combustível
local adp -- recebe o incrementador(adicionar) de pontos
local adc -- recebe o incrementador(adicionar) do combustível
local apd
local vcb
--local cometa
local foguete
--local planeta
--local estilingue
local pontosTxt
local grupoFoguete
local grupoCombComet
local grupoAsteroides
local distanciaTxt
local combustivelTxt
local toqueParaPausar
local transitionCometas
local transitionPlanetas
local grupoPlanetaEstilingue
local cos = math.cos
local sin = math.sin
local rad = math.rad
local atan2 = math.atan2
local deg = math.deg
local raio = 38 -- Distancia do estilingue do centro do planeta
local angulo = 90 -- Ponto de início da rotação
local atvFoguete = false
local atvOrbita = true
local aplicaForca = - 60
local speed = 8000
local speedPlanetas = 20000
local speedEstrelas = 3
local gameOver = {}
local perderCP = {}
local ganharCP = {}
local criarGrupos = {}
local criarOrbita = {}
local adicionarMarte = {}
local adicionarUrano = {}
local scrollEstrelas = {}
local carregarFoguete = {}
local adicionarPontos = {}
local adicionarPlutao = {}
local carregarImgsJogo = {}
local adicionarJupiter = {}
local adicionarSaturno = {}
local adicionarNeturno = {}
local controlarFoguete = {}
local adicionarDistancia = {}
local aumentarVelocidade = {}
local adicionarDisplayDCP = {}
local verificaCombustivel = {}
local adicionarCombustivel = {}
local adicionarCometasAnis = {}
local carregarObjCombustivel = {}
local adicionarCometasBrancos = {}
local adicionarAsteroidesCinzas ={}
local adicionarCometasVermelhos = {}
local adicionarAsteroidesMarrons = {}
local adicionarPlanetaPorDistancia = {}
local carregarCometasIniciaisPorDistancia = {}
local perderCombustivelPontosPorDistancia = {}
local carregarCometasAsteroidesPorDistancia = {}
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
    adp = timer.performWithDelay( 1000, adicionarPontos, 0 )
    add = timer.performWithDelay( 1000, adicionarDistancia, 0 )
    adc = timer.performWithDelay( 1000, adicionarCombustivel, 0 )
    coc = timer.performWithDelay( 5000, carregarObjCombustivel, 0 )
    apd = timer.performWithDelay( 1005, adicionarPlanetaPorDistancia, 0)
    pcp = timer.performWithDelay( 1005, perderCombustivelPontosPorDistancia, 0 )
    ccd = timer.performWithDelay( 1600, carregarCometasIniciaisPorDistancia, 15 )
    cad = timer.performWithDelay( 1600, carregarCometasAsteroidesPorDistancia, 0 )
    vcb = timer.performWithDelay( 1000, verificaCombustivel, 0)
    background:addEventListener("touch", controlarFoguete)
    Runtime:addEventListener("enterFrame", ativarFoguete)
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
function scene:hide(event)
  local sceneGroup = self.view
  local phase = event.phase

  if (phase == "will") then
    -- Chama quando a cena está na tela
    -- Inserir código para "pausar" a cena
    -- Ex: stop timers, stop animation, stop audio, etc
  elseif (phase == "did") then
    --Runtime.removeEventListener("enterFrame", criarOrbita)
    -- Chama imediatamente quando a cena está fora da tela
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Scene:destroy
--------------------------------------------------------------------------------
function scene:destroy(event)
  local sceneGroup = self.view

  Runtime:removeEventListener("touch", controlarFoguete)
  Runtime:removeEventListener("enterFrame", criarOrbita)
  Runtime:removeEventListener("enterFrame", ativarFoguete)
  Runtime:removeEventListener("enterFrame", scrollEstrelas)
  Runtime:removeEventListener("collision", onLocalCollision)
  display.remove(chao)
  display.remove(teto1)
  display.remove(teto2)
  display.remove(teto3)
  display.remove(cometa)
  display.remove(foguete)
  display.remove(planeta)
  display.remove(estilingue)
  display.remove(background)
  display.remove(grupoCombComet)
  display.remove(grupoAsteroides)
  display.remove(grupoPlanetaEstilingue)
  if (coc) then
    timer.cancel(coc)
    coc = nil
  end
  if (ccd) then
    timer.cancel(ccd)
    ccd = nil
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
  if (apd) then
    timer.cancel(apd)
    apd = nil
  end
  if (cad) then
    timer.cancel(cad)
    cad = nil
  end
  if (vcb) then
    timer.cancel(vcb)
    vcb = nil
  end
  --composer.removeScene( "jogo" )
  -- Chamado antes da remoção de vista da cena ("sceneGroup")
  -- Código para "limpar" a cena
  -- ex: remover obejtos display, save state, cancelar transições e etc
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

  teto1 = display.newImage("images/chaoMeteorito.png", display.contentWidth, display.contentHeight)
  teto1.x = display.contentCenterX - 30
  teto1.y = display.contentCenterY + 380
  teto1.name = 'teto'
  physics.addBody(teto1, "kinematic")
  teto1.isSensor = false
  scene.view:insert(teto1)

  teto2 = display.newImage("images/metero.png", display.contentWidth, display.contentHeight)
  teto2.x = 410
  teto2.y = -193
  teto2.name = 'teto'
  physics.addBody(teto2, "static")
  scene.view:insert(teto2)

  teto3 = display.newImage("images/metero.png", display.contentWidth, display.contentHeight)
  teto3.x = 1900
  teto3.y = -90
  teto3.name = 'teto'
  physics.addBody(teto3, "static")
  scene.view:insert(teto3)

  chao = display.newImageRect("images/chao.png", display.contentWidth, display.contentHeight)
  chao.x = display.contentCenterX
  chao.y = display.contentCenterY + 623
  chao.name = 'chao'
  physics.addBody(chao, "kinematic")
  teto1.isSensor = false
  scene.view:insert(chao)

  toqueParaPausar = display.newImage("images/botaoPausar.png", display.contentWidth, display.contentHeight)
  toqueParaPausar.x = display.contentCenterX - 430
  toqueParaPausar.y = display.contentCenterY - 277
  scene.view:insert(toqueParaPausar)
end
--------------------------------------------------------------------------------


---------------------------------S-----------------------------------------------
-- Carregar foguete
--------------------------------------------------------------------------------
function carregarFoguete()
  foguete = display.newImage("images/nave.png", display.contentWidth, display.contentHeight)
  foguete.x = 150
  foguete.y = 200
  foguete.name = 'foguete'
  foguete.isFixedRotation = true
  physics.addBody(foguete, "dynamic")
  foguete.isSensor = true
  scene.view:insert(foguete)
  --grupoFoguete:insert(foguete)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar objeto combustível
--------------------------------------------------------------------------------
function carregarObjCombustivel()
  objCombustivel = display.newImage("images/combustivel.png")
  objCombustivel.x = display.contentWidth + 150
  objCombustivel.y = math.random(25, display.contentHeight - 50 )
  objCombustivel.name = 'combustivel'
  physics.addBody( objCombustivel, "dynamic" )
  objCombustivel.isSensor = true
  transitionComb = transition.to( objCombustivel, {time = speed, x = -50, y = objCombustivel.y})
  grupoCombComet:insert(objCombustivel)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar display DCP(Distância, Combustível, Pontos)
--------------------------------------------------------------------------------
function adicionarDisplayDCP()
  displayPontos = display.newImage("images/displayPontos.png", display.contentWidth, display.contentHeight)
  displayPontos.x = display.contentCenterX - 240
  displayPontos.y = display.contentCenterY - 280
  scene.view:insert(displayPontos)
  pontosTxt = display.newText("0", display.contentWidth, display.contentHeight, "Visitor TT1 BRK", 36)
  pontosTxt.x = display.contentCenterX - 190
  pontosTxt.y = display.contentCenterY - 275
  scene.view:insert(pontosTxt)

  distanciaDisplay = display.newImage("images/displayDistancia.png", display.contentWidth, display.contentHeight)
  distanciaDisplay.x = display.contentCenterX - 10
  distanciaDisplay.y = display.contentCenterY - 275
  scene.view:insert(distanciaDisplay)
  distanciaTxt = display.newText("0", display.contentWidth, display.contentHeight, "Visitor TT1 BRK", 36)
  distanciaTxt.x = display.contentCenterX + 2
  distanciaTxt.y = display.contentCenterY - 275
  scene.view:insert(distanciaTxt)

  combustivelDisplay = display.newImage("images/displayCombustivel.png", display.contentWidth, display.contentHeight)
  combustivelDisplay.x = display.contentCenterX + 260
  combustivelDisplay.y = display.contentCenterY - 278
  scene.view:insert(combustivelDisplay)
  combustivelTxt = display.newText("0", display.contentWidth, display.contentHeight, "Visitor TT1 BRK", 36)
  combustivelTxt.x = display.contentCenterX + 240
  combustivelTxt.y = display.contentCenterY - 270
  scene.view:insert(combustivelTxt)
  --displayDCP = display.newImage("images/displayCDP.png", display.contentWidth, display.contentHeight)
  --displayDCP.x = display.contentCenterX
  --displayDCP.y = display.contentCenterY + 280
  --scene.view:insert(displayDCP)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar planeta por Distância
--------------------------------------------------------------------------------
function adicionarPlanetaPorDistancia()
  if (distancia == 30) then
    adicionarMarte()
  end
  if (distancia == 60) then
    adicionarJupiter()
  end
  if (distancia == 100) then
    adicionarSaturno()
  end
  if (distancia == 140) then
    adicionarUrano()
  end
  if (distancia == 180) then
    adicionarNeturno()
  end
  if (distancia == 220) then
    adicionarPlutao()
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adiciona planeta Marte
--------------------------------------------------------------------------------
function adicionarMarte()
  planeta = display.newImage("images/marte.png")
  planeta.x = display.contentWidth + 150
  planeta.y = display.contentCenterY - 20
  local cancelaOrbita = function(obj)
    transition.cancel(transitionPlanetas)
    Runtime:removeEventListener("enterFrame", criarOrbita)
    obj = nil
  end
  transitionPlanetas = transition.to( planeta, {time = speedPlanetas, x = -400, y = planeta.y, onComplete = cancelaOrbita})
  --physics.addBody(planeta, "dynamic")
  grupoPlanetaEstilingue:insert(planeta)

  estilingue = display.newImage("images/estilingue1.png")
  estilingue.name = 'estilingue'
  estilingue.isFixedRotation = true
  physics.addBody(estilingue, "kinematic")
  estilingue.isSensor = false
  grupoPlanetaEstilingue:insert(estilingue)

  Runtime:addEventListener("enterFrame", criarOrbita)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adiciona planeta Júpiter
--------------------------------------------------------------------------------
function adicionarJupiter()
  planeta = display.newImage("images/jupiter.png")
  planeta.x = display.contentWidth + 150
  planeta.y = display.contentCenterY - 20
  local cancelaOrbita = function(obj)
    transition.cancel(transitionPlanetas)
    Runtime:removeEventListener("enterFrame", criarOrbita)
    obj = nil
  end
  transitionPlanetas = transition.to( planeta, {time = speedPlanetas, x = -400, y = planeta.y, onComplete = cancelaOrbita})
  --physics.addBody(planeta, "dynamic")
  grupoPlanetaEstilingue:insert(planeta)

  estilingue = display.newImage("images/estilingue1.png")
  estilingue.name = 'estilingue'
  estilingue.isFixedRotation = true
  physics.addBody(estilingue, "kinematic")
  estilingue.isSensor = false
  grupoPlanetaEstilingue:insert(estilingue)

  Runtime:addEventListener("enterFrame", criarOrbita)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adiciona planeta Saturno
--------------------------------------------------------------------------------
function adicionarSaturno()
  planeta = display.newImage("images/saturno.png")
  planeta.x = display.contentWidth + 250
  planeta.y = display.contentCenterY + 30
  local cancelaOrbita = function(obj)
    transition.cancel(transitionPlanetas)
  end
  transitionPlanetas = transition.to( planeta, {time = speedPlanetas, x = -400, y = planeta.y, onComplete = cancelaOrbita})
  --physics.addBody(planeta, "dynamic")
  grupoPlanetaEstilingue:insert(planeta)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adiciona planeta Urano
--------------------------------------------------------------------------------
function adicionarUrano()
  planeta = display.newImage("images/urano.png")
  planeta.x = display.contentWidth + 150
  planeta.y = display.contentCenterY + 30
  local cancelaOrbita = function(obj)
    transition.cancel(transitionPlanetas)
  end
  transitionPlanetas = transition.to( planeta, {time = speedPlanetas, x = -400, y = planeta.y, onComplete = cancelaOrbita})
  --physics.addBody(planeta, "dynamic")
  grupoPlanetaEstilingue:insert(planeta)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adiciona planeta Neturno
--------------------------------------------------------------------------------
function adicionarNeturno()
  planeta = display.newImage("images/neturno.png")
  planeta.x = display.contentWidth + 150
  planeta.y = display.contentCenterY + 30
  local cancelaOrbita = function(obj)
    transition.cancel(transitionPlanetas)
    Runtime:removeEventListener("enterFrame", criarOrbita)
    obj = nil
  end
  transitionPlanetas = transition.to( planeta, {time = speedPlanetas, x = -400, y = planeta.y, onComplete = cancelaOrbita})
  --physics.addBody(planeta, "dynamic")
  grupoPlanetaEstilingue:insert(planeta)

  estilingue = display.newImage("images/estilingue1.png")
  estilingue.name = 'estilingue'
  estilingue.isFixedRotation = true
  physics.addBody(estilingue, "kinematic")
  estilingue.isSensor = false
  grupoPlanetaEstilingue:insert(estilingue)

  Runtime:addEventListener("enterFrame", criarOrbita)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adiciona planeta Neturno
--------------------------------------------------------------------------------
function adicionarPlutao()
  planeta = display.newImage("images/plutao.png")
  planeta.x = display.contentWidth + 150
  planeta.y = display.contentCenterY + 30
  local cancelaOrbita = function(obj)
    transition.cancel(transitionPlanetas)
  end
  transitionPlanetas = transition.to( planeta, {time = speedPlanetas, x = -400, y = planeta.y, onComplete = cancelaOrbita})
  --physics.addBody(planeta, "dynamic")
  grupoPlanetaEstilingue:insert(planeta)
  --Runtime:addEventListener("enterFrame", criarOrbita)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Criar/Configurar órbita
--------------------------------------------------------------------------------
function criarOrbita(event)
  estilingue.x = planeta.x  + cos(rad(angulo)) * raio * 5
  estilingue.y = planeta.y  + sin(rad(angulo)) * raio * 5
  --local anguloEstilingue = atan2(planeta.y-estilingue.y, planeta.x-estilingue.x)
  --estilingue.rotation = deg(anguloEstilingue)
  angulo = angulo + 3
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar cometas pela distância
--------------------------------------------------------------------------------
function carregarCometasIniciaisPorDistancia()
  if (distancia > 0 and distancia < 33) then
    cometa = display.newImage("images/cometaAzul.png")
    cometa.x = display.contentWidth + 150
    cometa.y = math.random(25, display.contentHeight - 50 )
    cometa.name = 'cometa'
    cometa.isFixedRotation = true
    physics.addBody(cometa, "dynamic")
    cometa.isSensor = true
    transitionCometas = transition.to( cometa, {time = speed, x = -500, y = cometa.y})
    grupoCombComet:insert(cometa)
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Carregar asteroides pela distância
--------------------------------------------------------------------------------
function carregarCometasAsteroidesPorDistancia()
    if (distancia > 43 and distancia < 57) then
      adicionarAsteroidesMarrons()
      --contador = contador + 1
      print('asteroide marrom')
    elseif (distancia > 73 and distancia < 97) then
      adicionarCometasVermelhos()
      --contador = contador + 1
      print('asteroide vermelho')
    elseif (distancia > 113 and distancia < 137) then
      adicionarCometasBrancos()
      --contador = contador + 1
      print('asteroide branco')
    elseif (distancia > 153 and distancia < 177) then
      adicionarCometasAnis()
      --contador = contador + 1
      print('asteroide anil')
    elseif (distancia > 193 and distancia < 227) then
      adicionarAsteroidesCinzas()
      --contador = contador + 1
      print('asteroide cinza')
    else
      print('saindo de carregarCometasAsteroidesPorDistancia()')
    end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar asteroides marrons (Marte -> Júpiter)
--------------------------------------------------------------------------------
function adicionarAsteroidesMarrons()
  local options = { width = 64, height = 64, numFrames = 30}
  local playerSheet = graphics.newImageSheet( "images/asteroideMarrom.png", options )
  local sequenceData = {
    { name = "rotacao", start = 1, count = 30 , time = 1000, loopCount = 0}
  }
  asteroide = display.newSprite( playerSheet, sequenceData )
  asteroide.x = display.contentWidth + 150
  asteroide.y = math.random(25, display.contentHeight - 50 )
  asteroide.name = 'cometa'
  asteroide.isFixedRotation = true
  physics.addBody(asteroide, "dynamic")
  asteroide.isSensor = true
  asteroide:play()
  grupoAsteroides:insert(asteroide)
  transitionCometas = transition.to( asteroide, {time = speed, x = -400, y = asteroide.y})
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar cometas vermelhos (Júpiter -> Saturno)
--------------------------------------------------------------------------------
function adicionarCometasVermelhos()
  cometa = display.newImage("images/cometaVermelho.png")
  cometa.x = display.contentWidth + 150
  cometa.y = math.random(20, display.contentHeight - 50 )
  cometa.name = 'cometa'
  cometa.isFixedRotation = true
  physics.addBody(cometa, "dynamic")
  cometa.isSensor = true
  scene.view:insert(cometa)
  transitionCometas = transition.to( cometa, {time = speed, x = -400, y = cometa.y})
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar cometas brancos (Saturno -> Urano)
--------------------------------------------------------------------------------
function adicionarCometasBrancos()
  cometa = display.newImage("images/cometaBranco.png")
  cometa.x = display.contentWidth + 150
  cometa.y = math.random(25, display.contentHeight - 50 )
  cometa.name = 'cometa'
  cometa.isFixedRotation = true
  physics.addBody(cometa, "dynamic")
  cometa.isSensor = true
  scene.view:insert(cometa)
  transitionCometas = transition.to( cometa, {time = speed, x = -400, y = cometa.y})
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar cometas rojões (Urano -> Neturno)
--------------------------------------------------------------------------------
function adicionarCometasAnis()
  cometa = display.newImage("images/cometaAnil.png")
  cometa.x = display.contentWidth + 150
  cometa.y = math.random(25, display.contentHeight - 50 )
  cometa.name = 'cometa'
  cometa.isFixedRotation = true
  physics.addBody(cometa, "dynamic")
  cometa.isSensor = true
  scene.view:insert(cometa)
  transitionCometas = transition.to( cometa, {time = speed, x = -400, y = cometa.y})
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar asteróides cinzas (Neturno -> Plutão)
--------------------------------------------------------------------------------
function adicionarAsteroidesCinzas()
  local options = { width = 64, height = 64, numFrames = 64}
  local playerSheet = graphics.newImageSheet( "images/asteroideCinza.png", options )
  local sequenceData = {
    { name = "rotacao", start = 1, count = 64 , time = 1000, loopCount = 0}
  }
  asteroide = display.newSprite( playerSheet, sequenceData )
  asteroide.x = display.contentWidth + 150
  asteroide.y = math.random(25, display.contentHeight - 50 )
  asteroide.name = 'cometa'
  asteroide.isFixedRotation = true
  physics.addBody(asteroide, "dynamic")
  asteroide.isSensor = true
  asteroide:play()
  grupoAsteroides:insert(asteroide)
  transitionCometas = transition.to( asteroide, {time = speed, x = -400, y = asteroide.y})
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Monitora a quantidade combustível no tanque da nave
--------------------------------------------------------------------------------
function verificaCombustivel()
  if (combustivel == 0) then
    print('Seu combustível se esgotou :/')
    gameOver()
  elseif(distancia <= 50) then
    print('Seu combustível está se esgotando!')
  end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar distância percorrida
--------------------------------------------------------------------------------
function adicionarDistancia()
    distancia = distancia + 1
    distanciaTxt.text = string.format("%d", distancia)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar combustível
--------------------------------------------------------------------------------
function adicionarCombustivel()
  combustivelTxt.text = string.format("%d", combustivel)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Adicionar pontos
--------------------------------------------------------------------------------
function adicionarPontos()
  pontosTxt.text = string.format("%d", pontos)
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Ativa o foguete ao clique aplicando força física
--------------------------------------------------------------------------------
function ativarFoguete(event)
    --self:applyForce(0, -2.5, self.x, self.y)
    if (atvFoguete) then
      aplicaForca = aplicaForca - 5
      foguete:setLinearVelocity(0, aplicaForca)
    end
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Controla o foguete evitando colisões
--------------------------------------------------------------------------------
function controlarFoguete(event)
  -- Ao clicar na tela é aplicada força na nave
  if (event.phase == "began") then
    atvFoguete = true
  end
  -- No fim do clique a força aplicada a nave é removida
  if (event.phase == "ended") then
    atvFoguete = false
    aplicaForca = - 50
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
    elseif (event.object1.name == "foguete" and event.object2.name == "cometa") then
        gameOver()
    elseif (event.object1.name == "cometa" and event.object2.name == "foguete") then
        gameOver()
    elseif (event.object1.name == "foguete" and event.object2.name == "teto") then
        gameOver()
    elseif (event.object1.name == "teto" and event.object2.name == "foguete") then
        gameOver()
    elseif (event.object1.name == "foguete" and event.object2.name == "chao") then
        gameOver()
    elseif (event.object1.name == "chao" and event.object2.name == "foguete") then
        gameOver()
    end
    if (event.object1.name == "teto" and event.object2.name == "cometa") then
      event.object2:removeSelf()
    end
    if (event.object1.name == "foguete" and event.object2.name == "estilingue") then
      event.object2:removeSelf()
      --Runtime:removeEventListener("enterFrame", criarOrbita)
      event.object2 = nil
      aumentarVelocidade()
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
-- A cada estilingue pegue a velocidade aumentará junto à difuldade
--------------------------------------------------------------------------------
function aumentarVelocidade()
  speedEstrelas = speedEstrelas + 2
  speed = speed + 3
  distancia = distancia + 2
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Realiza cálculo de incremento de combustível e de pontos de acordo com a distância percorrida
--------------------------------------------------------------------------------
function ganharCP ()
  combustivel = combustivel + 25
  pontos = pontos + 2
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- Realiza cálculo de decremento de combustível e de pontos de acordo com a distância percorrida
--------------------------------------------------------------------------------
function perderCP ()
  combustivel = combustivel - 25
end
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
-- A cada 500km percorridos serão decrementados combustível e pontos do jogador
--------------------------------------------------------------------------------
function perderCombustivelPontosPorDistancia()
  if (distancia == distanciaAux) then
    perderCP()
    distanciaAux = distanciaAux + 10
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
-- Cria grupo(s) para unir elementos da tela
--------------------------------------------------------------------------------
function criarGrupos( )
  --grupoFoguete = display.newGroup( )
  grupoCombComet = display.newGroup()
  grupoAsteroides = display.newGroup()
  grupoPlanetaEstilingue = display.newGroup()
  --scene.view:insert(grupoFoguete)
  scene.view:insert(grupoCombComet)
  scene.view:insert(grupoPlanetaEstilingue)
  scene.view:insert(grupoAsteroides)
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
