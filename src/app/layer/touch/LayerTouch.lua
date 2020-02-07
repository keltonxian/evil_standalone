local Info = require("app.base.Info")
local GUI = require("app.base.GUI")
local Util = require("app.base.Util")
local Touch = require("app.base.Touch")
local Scene = require("app.base.Scene")

local LayerTouch = class("LayerTouch", cc.Layer)

function LayerTouch:ctor()
	self._name = Info.LAYER_TOUCH
	self._mark_x = 32
	self._mark_y = 120
	self._btn_debug = nil
	self._touch_debug = nil
	self._is_debug = nil
	self._tap_count = 10

	Touch.regHandler(self, -Touch.ZORDER_LAYER_TOUCH, handler(self, self.handler), false)

	if true == Util.DEBUG_MODE then
		self:addDebug()
	end
end

function LayerTouch:handler(event, x, y)
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

function LayerTouch:onTouchBegan(x, y)
	--Util.log("layer_touch[%f][%f]", x, y)
	-- for open debug mode
	if true ~= self._is_debug and true ~= Util.DEBUG_MODE then
		if nil ~= Scene:getLayer(Info.LAYER_LOGIN) then
			if x > GUI.FULL_WIDTH - 100 and y > GUI.FULL_HEIGHT - 100 then
				self._tap_count = self._tap_count - 1
			end
			if self._tap_count < 0 then
				show_msg("开启debug模式");
				Util.DEBUG_MODE = true
				self:addDebug()
				Util.SHOW_ALL = true
			end
		end
	end
		---------------------
	self._touch_debug = nil
	if nil == self._btn_debug then
		return
	end
	local dx, dy = self._btn_debug:getPosition()
	if math.abs(x-dx) < 40 and math.abs(y-dy) < 40 then
		self._touch_debug = { dx = dx, dy = dy, has_move = false }
	end
	return true
end
	
function LayerTouch:onTouchMoved(x, y)
	if nil == self._touch_debug then
		return
	end
	local dx = self._touch_debug.dx
	local dy = self._touch_debug.dy
	if math.abs(x-dx) > 40 or math.abs(y-dy) > 40 then
		self._touch_debug.has_move = true
		self._btn_debug:setPosition(cc.p(x, y))
	end
end
	
function LayerTouch:onTouchEnded(x, y)
	if nil == self._touch_debug then
		return;
	end
	local dx = self._touch_debug.dx
	local dy = self._touch_debug.dy
	local has_move = self._touch_debug.has_move
	self._touch_debug = nil
	if true == has_move then
		local nx, ny
		if x > GUI.HALF_WIDTH then
			nx = GUI.FULL_WIDTH - 32
		else
			nx = 32
		end
		if y < 32 then
			ny = 32
		elseif y > GUI.FULL_HEIGHT - 32 then
			ny = GUI.FULL_HEIGHT - 32
		else
			ny = y
		end
		self._btn_debug:runAction(cc.MoveTo:create(0.1, cc.p(nx, ny)))
		self._mark_x = nx
		self._mark_y = ny
		return
	end
	self._btn_debug:runAction(cc.MoveTo:create(0.1, cc.p(dx, dy)))
	self._mark_x = dx
	self._mark_y = dy
	local layer = require("app.layer.test.LayerDebug"):create()
	Scene:addLayer(Touch.ZORDER_LAYER_DEBUG, layer)
end

function LayerTouch:cleanup()
	self._mark_x = nil
	self._mark_y = nil
	self._btn_debug = nil
	self._touch_debug = nil
	self._is_debug = nil
	self._tap_count = nil
end

function LayerTouch:remove()
	Scene:removeLayer(self)
end

function LayerTouch:addDebug()
	local fullpath = Util.getFullPath(Util.F_IMAGE, 'icon_debug.png')
	local pos = cc.p(self._mark_x, self._mark_y)
	local sprite = GUI.addSprite(self, fullpath, pos, GUI.ANCHOR_CENTER_CENTER)
	self._btn_debug = sprite
end

return LayerTouch

