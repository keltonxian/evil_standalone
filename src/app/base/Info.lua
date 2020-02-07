
local Info = class("Info")

Info.CPID               = 0
Info.CHANNEL_VER        = 0
Info.VER_APPSTORE       = 1

Info.IP_ADDR            = nil

-- layer name start --
Info.LAYER_NET = "LayerNet"
Info.LAYER_MSG = "LayerMsg"
Info.LAYER_PICK = "LayerPick"
Info.LAYER_DEBUG = "LayerDebug"
Info.LAYER_TOUCH = "LayerTouch"
Info.LAYER_LOADING = "LayerLoading"
Info.LAYER_PRELOAD = "LayerPreload"
Info.LAYER_LOGIN = "LayerLogin"
Info.LAYER_CHAPTER = "LayerChapter"
-- layer name end   --

function Info.isVer(cver)
	if cver == Info.CHANNEL_VER then
		return true
	end
	return false
end

return Info

