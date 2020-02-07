local Info = require("app.base.Info")
local GUI = require("app.base.GUI")
local Util = require("app.base.Util")
local Touch = require("app.base.Touch")
local Scene = require("app.base.Scene")

local LayerMsg = class("LayerMsg", cc.Layer)

function LayerMsg:ctor(msg, cb, size, can_close)
	self._name = Info.LAYER_MSG
	self._bg = nil
	self._callback = nil

	Touch.regHandler(self, -Touch.ZORDER_LAYER_MSG, handler(self, self.handler), true)

	self:init(msg, cb, size, can_close)
end

function LayerMsg:handler(event, x, y)
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

function LayerMsg:onTouchBegan(x, y)
	return true
end
	
function LayerMsg:onTouchMoved(x, y)
end
	
function LayerMsg:onTouchEnded(x, y)
end

function LayerMsg:cleanup()
	self._bg = nil
	self._callback = nil
end

function LayerMsg:remove()
	Scene:removeLayer(self)
end

function LayerMsg:init(msg, cb, size, can_close)
	self._callback = cb
	GUI.addLayerColor(self, cc.c4b(0, 0, 0, 100))

	local path = Util.getPath('bg_121.png')
	local frect = cc.rect(0, 0, 404, 260) -- fullrect
	local irect = cc.rect(200, 128, 4, 4) -- insetrect
	size = size or cc.size(GUI.wfix(540), GUI.wfix(288))
	local pos = cc.p(GUI.HALF_WIDTH, GUI.HALF_HEIGHT)
	local bg = GUI.addScale9Sprite(self, path, pos, GUI.ANCHOR_CENTER_CENTER, frect, irect, size, 10) 
	self._bg = bg

	if nil ~= msg then
		pos = cc.p(size.width/2, size.height-50)
		local lsize = cc.size(size.width-40, size.height - 80 - 100)
		GUI.addLabelOutline(bg, msg, nil, 25, pos, GUI.c4b_white, GUI.c4b_black, 1, GUI.ANCHOR_CENTER_UP, 50, lsize, cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_TOP)
	end

	local items = {}

	pos = cc.p(206, 11)
	GUI.addItem2(items, 'btn_122.png', 'btn_122_s.png', handler(self, self.action), GUI.ANCHOR_LEFT_DOWN, pos)

	if true == can_close then
		pos = cc.p(474, 213)
		GUI.addItemClose(items, pos, GUI.ANCHOR_LEFT_DOWN, handler(self, self.back))
	end

	GUI.addMenu(bg, items, 60)
end

function LayerMsg:back()
	self:remove()
end

function LayerMsg:action()
	local cb = self._callback
	self:back()
	if nil ~= cb then
		cb()
	end
end

return LayerMsg

