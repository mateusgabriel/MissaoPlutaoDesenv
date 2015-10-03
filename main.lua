display.setStatusBar( display.HiddenStatusBar )
math.randomseed( os.time() )

local composer = require ("composer")
composer.gotoScene("menu")


--------------------------------------------------------------------------------
-- Variáveis globais
--------------------------------------------------------------------------------
distancia = 0
distanciaAux = 250
combustivel = 1000
pontos = 0
_W = display.contentWidth
_H = display.contentHeight
_W2 = display.contentCenterX
_H2 = display.contentCenterY
