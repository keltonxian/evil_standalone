local Info = require("app.base.Info")
local GUI = require("app.base.GUI")
local Util = require("app.base.Util")
local Touch = require("app.base.Touch")
local Scene = require("app.base.Scene")

local LayerDebug = class("LayerDebug", cc.Layer)

function LayerDebug:ctor()
	self._name = Info.LAYER_DEBUG
	self._stage = nil
	self._label_texture = nil

	Touch.regHandler(self, -Touch.ZORDER_LAYER_DEBUG, handler(self, self.handler), true)
end

function LayerDebug:handler(event, x, y)
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

function LayerDebug:onTouchBegan(x, y)
	return true
end
	
function LayerDebug:onTouchMoved(x, y)
end
	
function LayerDebug:onTouchEnded(x, y)
	self:remove()
end

function LayerDebug:cleanup()
	self._stage = nil
	self._label_texture = nil
end

function LayerDebug:remove()
	Scene:removeLayer(self)
end

function LayerDebug:init()
	GUI.addLayerColor(self, cc.c4b(0, 0, 0, 128))

	self._stage = Scene._this_stage

	local pos, string
	pos = cc.p(GUI.FULL_WIDTH, GUI.FULL_HEIGHT)
	string = 'LOGIC_VER: ' .. Util.LOGIC_VERSION
	string = string .. '\nGAME_VER: ' .. Util.GAME_VERSION
	GUI.addLabel(self, string, 30, pos, GUI.c_white, GUI.ANCHOR_RIGHT_UP)

	pos = cc.p(GUI.FULL_WIDTH, GUI.FULL_HEIGHT - 100)
	local cache = cc.Director:getInstance():getTextureCache()
	string = cache:getCachedTextureInfo()
	local sp = string.find(string, "TextureCache dumpDebugInfo", 1)
	string = string.sub(string, sp, string.len(string))
	self._label_texture = GUI.addLabel(self, string, 25, pos, GUI.c_white, GUI.ANCHOR_RIGHT_UP, nil, cc.size(GUI.HALF_WIDTH, 150), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

	local items = {}
	local item
	local size = cc.size(172, 52)
	local y = GUI.FULL_HEIGHT - 250

	pos = cc.p(GUI.FULL_WIDTH, y)
	item = GUI.addItem1(items, '清除', nil, 20, handler(self, self.clean), GUI.ANCHOR_RIGHT_UP, pos, size)

	y = y - 70
	pos = cc.p(GUI.HALF_WIDTH, y)
	item = GUI.addItem1(items, '重开', nil, 20, Util.relaunchGame, GUI.ANCHOR_CENTER_UP, pos, size)

	y = y - 70
	pos = cc.p(GUI.FULL_WIDTH, y)
	item = GUI.addItem1(items, '清教程', nil, 20, Tutor.resetTutor, GUI.ANCHOR_RIGHT_UP, pos, size)

	y = y - 70
	pos = cc.p(GUI.FULL_WIDTH, y)
	item = GUI.addItem1(items, '首登介绍', nil, 20, handler(self, self.testTutorIntro), GUI.ANCHOR_RIGHT_UP, pos, size)

	y = y - 70
	pos = cc.p(GUI.FULL_WIDTH, y)
	--item = GUI.addItem1(items, '清闯关教程', nil, 20, Util.resetSvgTutor, GUI.ANCHOR_RIGHT_UP, pos, size)
	item = GUI.addItem1(items, '牌堆教程', nil, 20, handler(self, self.testTutorDeck), GUI.ANCHOR_RIGHT_UP, pos, size)

	y = y - 70
	pos = cc.p(GUI.FULL_WIDTH, y)
	item = GUI.addItem1(items, '碎片教程', nil, 20, handler(self, self.testTutorPiece), GUI.ANCHOR_RIGHT_UP, pos, size)

	GUI.addMenu(self, items, 1)

	local lstr = ''
	local list = Scene:getLayerList()
	for i = 1, #list do
		local t = list[i]
		lstr = '\n' .. t .. lstr
	end
	pos = cc.p(GUI.FULL_WIDTH, 0)
	GUI.addLabel(self, lstr, 25, pos, GUI.c_white, GUI.ANCHOR_RIGHT_DOWN, nil, cc.size(GUI.HALF_WIDTH, GUI.HALF_HEIGHT), cc.TEXT_ALIGNMENT_RIGHT, cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM)

	if Scene:isStage(Scene.STAGE_LOGIN) then
		self:forLogin()
	elseif Scene:isStage(Scene.STAGE_PVP) or Scene:isStage(Scene.STAGE_PVE) then
		self:forGame()
	elseif Scene:isStage(Scene.STAGE_MAP) then
		self:forMap()
	end
end

function LayerDebug:forLogin()
	local items = {}
	local item, pos

	local size = cc.size(172, 52)
	pos = cc.p(0, GUI.FULL_HEIGHT)
	item = GUI.addItem1(items, '卡牌测试', nil, 20, handler(self, self.debugCard), GUI.ANCHOR_LEFT_UP, pos, size)

	pos = cc.p(0, GUI.FULL_HEIGHT-100)
	item = GUI.addItem1(items, '单机测试', nil, 20, handler(self, self.debugLocal), GUI.ANCHOR_LEFT_UP, pos, size);

	pos = cc.p(0, GUI.FULL_HEIGHT-200);
	item = GUI.addItem1(items, '功能(lua)', nil, 20, handler(self, self.debugFunction), GUI.ANCHOR_LEFT_UP, pos, size)

	--[[
	pos = cc.p(0, GUI.FULL_HEIGHT-300)
	item = GUI.addItem1(items, '测试下载', nil, 20, handler(self, self.testDRes), GUI.ANCHOR_LEFT_UP, pos, size)
	]]--

	pos = cc.p(0, GUI.FULL_HEIGHT-400)
	item = GUI.addItem1(items, '删除资源', nil, 20, handler(self, self.deleteRes), GUI.ANCHOR_LEFT_UP, pos, size)

	--[[
	pos = cc.p(0, GUI.FULL_HEIGHT-500)
	item = GUI.addItem1(items, '重下资源', nil, 20, handler(self, self.reloadRes), GUI.ANCHOR_LEFT_UP, pos, size)
	]]--

	pos = cc.p(0, GUI.FULL_HEIGHT-600)
	item = GUI.addItem1(items, '本地通知', nil, 20, handler(self, self.localPush), GUI.ANCHOR_LEFT_UP, pos, size)

	pos = cc.p(0, GUI.FULL_HEIGHT-700)
	item = GUI.addItem1(items, '清楚IAP记录', nil, 20, handler(self, self.cleanIapRecord), GUI.ANCHOR_LEFT_UP, pos, size)

	--pos = cc.p(0, GUI.FULL_HEIGHT-700)
	--item = GUI.addItem1(items, 'IOS IAP', nil, 20, handler(self, self.testIap), GUI.ANCHOR_LEFT_UP, pos, size)

	--[[
	pos = cc.p(0, 300)
	item = GUI.createItemSprite2(fname1,fname2,pos,GUI.ANCHOR_LEFT_UP,handler(self,self.debugCFunction),'功能(c++)')
	table.insert(items, item)

	if true == RELOAD_MODE and true == DEBUG_MODE then
		pos = cc.p(0, 400)
		item = GUI.createItemSprite2(fname1,fname2,pos,GUI.ANCHOR_LEFT_UP,handler(self,self.restart),'重开')
		items:addObject(item)
		--GUI.addLabelTTF(self, '重开，即重新回到更新界面进行更新，会使用上面的服务器地址来进行更新，想得到不同地方的lua，可切换上面的服务器再点更新，此操作不会记录于本地，下次打开程序时，依旧会用默认的211.149.186.201进行更新', GUI.f_default, 23, cc.p(GUI.HALF_WIDTH, 140), GUI.c_black, GUI.ANCHOR_CENTER_UP, data.zorder, CCSizeMake(FULL_WIDTH, 140), kCCTextAlignmentLeft);
	end
	]]--

	GUI.addMenu(self, items, 1)
end

function LayerDebug:forGame()
	local pos, string
	pos = cc.p(0, GUI.FULL_HEIGHT)
	local count = 0
	for k, v in pairs(GUI.g_sprite_cache or {}) do
		count = count + 1;
	end
	string = '当前绘制卡牌数量: ' .. count
	GUI.addLabel(self, string, 25, pos, GUI.c_white, GUI.ANCHOR_LEFT_UP, nil, cc.size(GUI.HALF_WIDTH, 200), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_TOP)

	local items = {}
	local item, pos

	local size = cc.size(172, 52)
	pos = cc.p(0, GUI.FULL_HEIGHT/4*3)
	item = GUI.addItem1(items, '@win', nil, 20, self.winAi, GUI.ANCHOR_LEFT_UP, pos, size)

	GUI.addMenu(self, items, 1)
end

function LayerDebug:forMap()
	local items = {}
	local item, pos

	local size = cc.size(172, 52)
	pos = cc.p(0, GUI.FULL_HEIGHT)
	item = GUI.addItem1(items, '创建比赛', nil, 20, handler(self, self.createMatch), GUI.ANCHOR_LEFT_UP, pos, size)

	pos = cc.p(0, GUI.FULL_HEIGHT-90)
	item = GUI.addItem1(items, '剧情教程', nil, 20, Tutor.tutorLocal, GUI.ANCHOR_LEFT_UP, pos, size)

	pos = cc.p(0, GUI.FULL_HEIGHT-180)
	item = GUI.addItem1(items, 'pay_ad', nil, 20, handler(Scene, Scene.showPayAd), GUI.ANCHOR_LEFT_UP, pos, size)

	pos = cc.p(0, GUI.FULL_HEIGHT-270)
	item = GUI.addItem1(items, 'chat', nil, 20, handler(Scene, Scene.showChat), GUI.ANCHOR_LEFT_UP, pos, size)

	--pos = cc.p(0, GUI.FULL_HEIGHT-270)
	--item = GUI.addItem1(items, '新solo列表', nil, 20, handler(Scene, Scene.showListSolo), GUI.ANCHOR_LEFT_UP, pos, size)


	GUI.addMenu(self, items, 1)
end

function LayerDebug:createMatch()
	self:remove()
	local layer = require("app.layer.game.LayerCMatch"):create()
	Scene:addLayer(Touch.ZORDER_LAYER_CMATCH, layer)
end

return LayerDebug

