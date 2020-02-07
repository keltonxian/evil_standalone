local Info = require("app.base.Info")
local Util = require("app.base.Util")
local GUI = require("app.base.GUI")
local Audio = require("app.base.Audio")
local Touch = require("app.base.Touch")
local Scene = require("app.base.Scene")
local Net = require("app.base.Net")
local LayerNet = require("app.layer.net.LayerNet")
local LayerTouch = require("app.layer.touch.LayerTouch")

local ScenePreload = class("ScenePreload", cc.Layer)

ScenePreload.WAIT     = 1
ScenePreload.START    = 2

function ScenePreload.showScene()
	local stage = Scene.STAGE_PRELOAD
	local scene = cc.Scene:create()
	local layer_list = {}
	local layer

	layer = LayerNet:create()
	scene:addChild(layer, Touch.ZORDER_LAYER_NET)
	table.insert(layer_list, layer)

	layer = ScenePreload:create(callback, action, res_stage)
	scene:addChild(layer, Touch.ZORDER_LAYER_PRELOAD)
	table.insert(layer_list, layer)

	layer = LayerTouch:create()
	scene:addChild(layer, Touch.ZORDER_LAYER_TOUCH)
	table.insert(layer_list, layer)

	Scene:changeScene(scene, stage, layer_list)
end

function ScenePreload:ctor(...)
	self:initLayer(...)
end

function ScenePreload:initLayer(callback, action, res_stage)
	self._name = Info.LAYER_PRELOAD

	Touch.regHandler(self, -Touch.ZORDER_LAYER_PRELOAD, handler(self, self.handler), true)

	self._callback = callback
	self._list = self:getList(res_stage)
	self._label_num = nil
	self._label_tip = nil

	local path, sprite, pos, str
	path = Util.getPath('bg_200.png')
	pos = cc.p(GUI.HALF_WIDTH, GUI.HALF_HEIGHT)
	sprite = GUI.addSprite(self, path, pos, GUI.ANCHOR_CENTER_CENTER)
	if GUI.wfix(1) > GUI.hfix(1) then
		sprite:setScale(GUI.wfix(1))
	else
		sprite:setScale(GUI.hfix(1))
	end

	path = Util.getPath('bg_191.png')
	local fullrect = cc.rect(0, 0, 64, 64)
	local insetrect = cc.rect(30, 30, 4, 4)
	local bgsize = cc.size(GUI.wfix(512), GUI.hfix(80))
	pos = cc.p(GUI.HALF_WIDTH, GUI.HALF_HEIGHT-GUI.hfix(100))
	local bg = GUI.addScale9Sprite(self, path, pos, GUI.ANCHOR_CENTER_CENTER, fullrect, insetrect, bgsize)

	str = "加载中..."
	pos = cc.p(20, bgsize.height/2)
	self._label_tip = GUI.addLabelOutline(bg, str, nil, 30, pos, GUI.c4b_white, GUI.c4b_black, 2, GUI.ANCHOR_LEFT_CENTER, 50, cc.size(bgsize.width-40, bgsize.height), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)

	path = util.get_path(Util.FNT_1)
	pos = cc.p(bgsize.width-20, bgsize.height/2)
	str = "0%"
	self._label_num = GUI.addLabelBMF(bg,str,path,pos,GUI.ANCHOR_RIGHT_CENTER,50)

	if action == self.START then
		self:start()
	end
end

function ScenePreload:handler(event, x, y)
	if "began" == event then   
		return self:onTouchBegan(x, y)
	elseif "moved" == event then
		return self:onTouchMoved(x, y)
	elseif "ended" == event or "cancelled" == event then
		return self:onTouchEnded(x, y)
	elseif "enter" == event then
		Util.freeRam()
	elseif "exit" == event then
		self:cleanup()
	elseif "backClicked" == event then
	end
end

function ScenePreload:onTouchBegan(x, y)
	return true
end
	
function ScenePreload:onTouchMoved(x, y)
	
end
	
function ScenePreload:onTouchEnded(x, y)

end

function ScenePreload:cleanup()
	self._list = nil
	self._label_num = nil
	self._label_tip = nil
end

function ScenePreload:remove()
	Scene:removeLayer(self)
end

function ScenePreload:start()
	self:scheduleUpdateWithPriorityLua(handler(self, self.loadRes), 1)
end

function ScenePreload:finish()
	self:remove()
	self._callback()
end

function ScenePreload:getList(stage)
	local list = {}
	if stage == Scene.STAGE_PVP or 
	   stage == Scene.STAGE_PVE or 
	   stage == Scene.STAGE_PVG then
		self:getGUIRes(list, GUI.GUI_MATCH)
	end
	return list
end

function ScenePreload:getGUIRes(list, ltype)
	local res_list = GUI.getList(ltype)
	for k, v in pairs(res_list) do
		if nil ~= v then
			if nil ~= v.filename1 and "0" ~= v.filename1 then
				local path = Util.getPath(v.filename1)
				table.insert(list, path)
			end
			if nil ~= v.filename2 and "0" ~= v.filename2 then
				local path = Util.getPath(v.filename2)
				table.insert(list, path)
			end
		end
	end
end

function ScenePreload:loadRes(dt)
	--Audio.preloadEffect(Util.getFullPath(Util.F_MUSIC, 'eff_win.mp3'))
	--Audio.preloadEffect(Util.getFullPath(Util.F_MUSIC, 'eff_lose.mp3'))
	--Audio.preloadEffect(Util.getFullPath(Util.F_MUSIC, 'eff_draw.mp3'))
	Audio.preloadEffect(Util.getPath('eff_win.mp3'))
	Audio.preloadEffect(Util.getPath('eff_lose.mp3'))
	Audio.preloadEffect(Util.getPath('eff_draw.mp3'))
	local list = self._list or {}
	local count = 0
	local total = #list
	Util.log("load_res total[%d]", total)
	if 0 == total then
		self:unscheduleUpdate()
		self:finish()
		return
	end
	local function cb_load(texture)
		count = count + 1
		local p = string.format("%.2f%%", count / total * 100)
		self._label_num:setString(p)
		if count >= total then
			self:finish()
		end
		return
	end
	local cache = cc.Director:getInstance():getTextureCache()
	for i = 1, #list do
		local path = list[i]
		cache:addImageAsync(path, cb_load)
	end
	self:unscheduleUpdate()
end

return ScenePreload

