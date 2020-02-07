local Info = require("app.base.Info")
local GUI = require("app.base.GUI")
local Util = require("app.base.Util")
local Audio = require("app.base.Audio")
local Info = require("app.base.Info")

local Scene = class("Scene")

local g_instance = nil

local function Instance()
	if nil == g_instance then
		g_instance = Scene:create()
	end
	return g_instance
end

-- scene stage start
Scene.STAGE_LOGIN       = 1
Scene.STAGE_PVP         = 2
Scene.STAGE_MAP         = 3
Scene.STAGE_ROLE        = 4
Scene.STAGE_DECK        = 5
Scene.STAGE_SHOP        = 6
Scene.STAGE_TESTLUA     = 7
Scene.STAGE_TESTC       = 8
Scene.STAGE_PVE         = 9
Scene.STAGE_PRELOAD     = 10
--Scene.STAGE_INFO        = 11
Scene.STAGE_REPLAY      = 12
Scene.STAGE_RANK        = 13
Scene.STAGE_GM          = 14
Scene.STAGE_OPTION      = 15
Scene.STAGE_LGUILD      = 16
Scene.STAGE_GUILD       = 17
Scene.STAGE_WELFARE     = 18
Scene.STAGE_LMEMBER     = 19
Scene.STAGE_LAPPLY      = 20
Scene.STAGE_LSTOCK      = 21
Scene.STAGE_INVEST      = 22
--Scene.STAGE_LDEPOSIT    = 23
Scene.STAGE_PCLG        = 24
--Scene.STAGE_MAIL        = 25
Scene.STAGE_PVG         = 26
Scene.STAGE_HERO        = 27
Scene.STAGE_CHAPTER     = 28
Scene.STAGE_MYDECK      = 29
Scene.STAGE_PICKDECK    = 30
Scene.STAGE_SGDECK      = 31
Scene.STAGE_PIECE       = 32
Scene.STAGE_MYSTERY     = 33
Scene.STAGE_LOADRES     = 34
Scene.STAGE_BOOK        = 35
-- scene stage end

function Scene:ctor(...)
	self._last_stage = nil
	self._this_stage = nil
	self._this_scene = nil
	self._is_connected = false
	self._layer_list = {}
end

function Scene:addLayerList(layer)
	local name = layer._name
	self._layer_list = self._layer_list or {}
	name = name or '???'
	name = name .. '\n'
	table.insert(self._layer_list, { layer = layer, name = name })
end

function Scene:getLayerList()
	self._layer_list = self._layer_list or {}
	return self._layer_list
end

function Scene:resetLayerList()
	self._layer_list = {}
end

function Scene:getLayer(layer_name)
	for i = 1, #self._layer_list do
		local data = self._layer_list[i]
		if name == data.name then
			return data.layer
		end
	end
	return nil
end

function Scene:addLayer(zorder, layer, is_show_anim, callback)
	local director = cc.Director:getInstance()
	--local scene = director:getRunningScene()
	local scene = self._this_scene or director:getRunningScene()
	if nil == scene then
		Util.err("current_scene is nil")
		return
	end
	scene:addChild(layer, zorder)
	self:addLayerList(layer)
	if true == is_show_anim then
		GUI.showPopAnim(layer, callback)
	end
end

function Scene:removeLayer(layer)
	if nil == layer then
		return
	end
	local name = layer._name
	layer:removeFromParent(true)
	self:deleteLayerList(name)
end

function Scene:deleteLayerList(name)
	self._layer_list = self._layer_list or {}
	name = name .. '\n'
	local index = 0
	for i = 1, #self._layer_list do
		local data = self._layer_list[i]
		if name == data.name then
			index = i
			break
		end
	end
	if 0 == index then
		return
	end
	table.remove(self._layer_list, index)
end

function Scene:isInBattle(stage)
	stage = stage or self._this_stage
	if stage == Scene.STAGE_PVE or stage == Scene.STAGE_PVP or stage == Scene.STAGE_REPLAY or stage == Scene.STAGE_PVG then
		return true
	end
	return false
end

function Scene:changeScene(new_scene, new_stage, layer_list)
	local director = cc.Director:getInstance()
	if nil ~= director:getRunningScene() then
		director:replaceScene(new_scene)
	else
		director:runWithScene(new_scene)
	end

	Audio.resumeBGMusic()
	if new_stage == Scene.STAGE_LOGIN or self:isInBattle(self._this_stage) then
		local path = Util.getPath('main.mp3')
		Audio.preloadMusic(path)
		Audio.playBGMusic(path)
	elseif self:isInBattle(new_stage) then
		local path = Util.getPath('battle.mp3')
		Audio.preloadMusic(path)
		Audio.playBGMusic(path)
	end

	self._last_stage = self._this_stage
	self._this_stage = new_stage
	self._this_scene = new_scene

	self:resetLayerList()
	for i = 1, #(layer_list or {}) do
		local layer = layer_list[i]
		self:addLayerList(layer)
	end
end

function Scene:isOnline()
	return self._is_connected
end

function Scene:isStage(stage)
	if self._this_stage == stage then
		return true
	end
	return false
end

function Scene:preload(callback, action, res_stage)
	require("app.scene.ScenePreload").showScene(callback, action, res_stage)
end

function Scene:showPayAd()
	local layer = require("app.layer.pop.LayerPayAd"):create()
	Scene:addLayer(Touch.ZORDER_LAYER_PAY_AD, layer, true)
end

function Scene:showChat()
	local layer = require("app.layer.pop.LayerChat"):create()
	Scene:addLayer(Touch.ZORDER_LAYER_CHAT, layer, true)
end

function Scene:showListSolo()
	--local layer, name = layer_chapter:create();
	--g_scene:add_layer(ZORDER_LAYER_CHAPTER, layer, name, true);
	--net_send('list_solo ' .. g_euser.solo_pos, true);
	--g_scene:go(GUI_CHAPTER, "chapter");
	require("app.scene.SceneChapter").showScene()
end

function Scene:showMap()
		data_handler:cleanup();
		local stage = STAGE_MAP;
		local scene = cc.Scene:create();
		local layer_list = {};
		local layer, name;

		layer, name = layer_net:create();
		scene:addChild(layer, ZORDER_LAYER_NET);
		table.insert(layer_list, name);

		layer, name = layer_map:create();
		scene:addChild(layer, ZORDER_LAYER_MAP);
		table.insert(layer_list, name);

		layer, name = layer_infobar:create();
		scene:addChild(layer, ZORDER_LAYER_INFOBAR);
		table.insert(layer_list, name);

		--[[
		layer, name = layer_bottombar:create();
		scene:addChild(layer, ZORDER_LAYER_BOTTOMBAR);
		table.insert(layer_list, name);

		layer, name = layer_chat:create();
		scene:addChild(layer, ZORDER_LAYER_CHAT);
		table.insert(layer_list, name);
		]]--

		layer, name = layer_touch:create();
		scene:addChild(layer, ZORDER_LAYER_TOUCH);
		table.insert(layer_list, name);

		self:change_scene(scene, stage, layer_list);

		if true == check_do_tutor_wait_net() then
			return;
		end
		--[[
		if false == OLD_TUTOR then return; end
		-- see net_mreward, net_course
		local show_tutor = false;
		if false == show_tutor then
			show_tutor = show_tutor_gate();
		end
		if false == show_tutor then
			show_tutor = show_tutor_mission();
		end
		net_send('course', true);
		]]--
end

function Scene:showLoading(text)
	local layerLoading = self:getLayer(Info.LAYER_LOADING)
	if nil ~= layer_loading then
		return
	end
	local layer = require("app.layer.loading.LayerLoading"):create(text)
	Scene:addLayer(Touch.ZORDER_LAYER_LOADING, layer)
end

function Scene:hideLoading()
	local layerLoading = self:getLayer(Info.LAYER_LOADING)
	if nil ~= layer_loading then
		return
	end
	layerLoading:remove()
end

function Scene:showNetLoading()
	local str = '联网中...'
	self:showLoading(str)
end

function Scene:hideNetLoading()
	self:hideLoading()
end

function Scene:connectToNet = function(self)
	local ret = LayerSocket:initSocket(Info.IP_ADDR)
	if ret <= 0 then
		--local err = string.format("initSocket ret[%d], ip[%s]",ret,Info.IP_ADDR)
		local err = string.format("服务器维护中,请稍后再试...")
		net_show_err(nil, err)
		return ret
	end
	self._is_connected = true
	return 1
end,

function Scene:closeConnect()
	if false == self._is_connected then
		return
	end
	Net:netSend('q')
	self._is_connected = false
end

return Instance()

