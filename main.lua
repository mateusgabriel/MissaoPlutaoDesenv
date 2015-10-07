display.setStatusBar( display.HiddenStatusBar )

--------------------------------------------------------------------------------
-- Configuração de transição para menu
--------------------------------------------------------------------------------
local configTransicaoMenu = {
	effect = "fade", time = 1600
}
--------------------------------------------------------------------------------

local composer = require ("composer")
composer.gotoScene("menu", configTransicaoMenu)


--------------------------------------------------------------------------------
-- Variáveis globais
--------------------------------------------------------------------------------
distancia = 0
distanciaAux = 250
combustivel = 1000
pontos = 0
