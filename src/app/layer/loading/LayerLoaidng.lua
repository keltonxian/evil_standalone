local Info = require("app.base.Info")
local Util = require("app.base.Util")
local GUI = require("app.base.GUi")
local Touch = require("app.base.Touch")

local LayerLoading = class("LayerLoading", cc.Layer)

function LayerLoading:ctor()
	self._name = Info.LAYER_LOADING

	Touch.regHandler(self, -Touch.ZORDER_LAYER_LOADING, handler(self, self.handler), true)

	self:init()
end

function LayerLoading:handler(event, x, y)
	if "began" == event then   
		return self:onTouchBegan(x, y)
	elseif "moved" == event then
		return self:onTouchMoved(x, y)
	elseif "ended" == event or "cancelled" == event then
		return self:onTouchEnded(x, y)
	elseif "enter" == event then
	elseif "exit" == event then
		self:cleanup()
	elseif "backClicked" == event then
	end
end

function LayerLoading:onTouchBegan(x, y)
	return true
end
	
function LayerLoading:onTouchMoved(x, y)
end
	
function LayerLoading:onTouchEnded(x, y)
	self:remove()
end

function LayerLoading:cleanup()
end

function LayerLoading:remove()
	Scene:removeLayer(self)
end

function LayerLoading:init()
	GUI.addLayerColor(self, cc.c4b(0, 0, 0, 128))

	local path = Util.getPath('bg_191.png')
	local fullrect = cc.rect(0, 0, 64, 64)
	local insetrect = cc.rect(30, 30, 4, 4)
	local size = cc.size(GUI.wfix(300), GUI.wfix(120))
	local pos = cc.p(GUI.HALF_WIDTH, GUI.HALF_HEIGHT);
	local bg = GUI.addScale9Sprite(self, path, pos, GUI.ANCHOR_CENTER_CENTER, fullrect, insetrect, size, 10)

	path = Util.getPath('icon_loading.png')
	pos = cc.p(wfix(60), size.height/2)
	sprite = GUI.addSprite(bg, path, pos, GUI.ANCHOR_CENTER_CENTER)
	sprite:runAction(cc.RepeatForever:create(cc.RotateBy:create(0.1, 30)))

	text = text or '...'
	local pos = cc.p(GUI.HALF_WIDTH, GUI.HALF_HEIGHT)
	pos = cc.p(GUI.wfix(130), size.height/2)
	GUI.addLabel(bg, text, 30, pos, GUI.c_white, GUI.ANCHOR_LEFT_CENTER)
end

return LayerLoading

