display.setStatusBar( display.HiddenStatusBar )

--------------------------------------------------------------------------------
-- Configuração de transição para menu
--------------------------------------------------------------------------------
local configTransicaoMenu = {
	effect = "fade", time = 1600
}
--------------------------------------------------------------------------------

local composer = require ("composer")
composer.gotoScene("submenu", configTransicaoMenu)


--------------------------------------------------------------------------------
-- Variáveis globais
--------------------------------------------------------------------------------
distancia = 0
distanciaAux = 25
combustivel = 100
pontos = 0
--vidasAux = 5
--vidas = 0
