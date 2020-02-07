local Info = require("app.base.Info")
local Touch = require("app.base.Touch")
local Scene = require("app.base.Scene")

local LayerNet = class("LayerNet", LayerSocket)

function LayerNet:ctor(...)
	self._name = Info.LAYER_NET
	Touch.regHandler(self, -Touch.ZORDER_LAYER_NET, handler(self, self.handler), true)
end

function LayerNet:handler(event, x, y)
	if "began" == event then   
		return self:onTouchBegan(x, y)
	elseif "moved" == event then
		return self:onTouchMoved(x, y)
	elseif "ended" == event or "cancelled" == event then
		return self:onTouchEnded(x, y)
	elseif "enter" == event then
		--util.reg_net(self.layer, self.net_handler);
	elseif "exit" == event then
		--util.unreg_net(self.layer);
		self:cleanup()
	elseif "backClicked" == event then
	end
end

function LayerNet:onTouchBegan(x, y)
	return true
end
	
function LayerNet:onTouchMoved(x, y)
	
end
	
function LayerNet:onTouchEnded(x, y)

end

function LayerNet:remove()
	Scene:removeLayer(self)
end

function LayerNet:cleanup()
end

return LayerNet

