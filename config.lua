application =
{

	content =
	{
		width = 320,
    height = 480,
    scale = "letterbox",
    xAlign = "center",
    yAlign = "center",
    imageSuffix = {
    ["@2x"] = 2,
		--width = 320,
		--height = 480,
		--scale = "adaptative" --,zoomEven, letterbox, adaptative, zoomStretch
		--fps = 30,

		--[[
		imageSuffix =
		{
			    ["@2x"] = 2,
		},
		--]]
	},-

	--[[
	-- Push notifications
	notification =
	{
		iphone =
		{
			types =
			{
				"badge", "sound", "alert", "newsstand"
			}
		}
	},
	--]]
}
