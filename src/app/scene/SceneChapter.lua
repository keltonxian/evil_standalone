local Info = require("app.base.Info")
local Util = require("app.base.Util")
local GUI = require("app.base.GUI")
local Audio = require("app.base.Audio")
local Touch = require("app.base.Touch")
local Scene = require("app.base.Scene")
local Anim = require("app.base.Anim")
local Net = require("app.base.Net")
local LayerNet = require("app.layer.net.LayerNet")
local LayerTouch = require("app.layer.touch.LayerTouch")

local SceneChapter = class("SceneChapter", cc.Layer)

function SceneChapter.showScene()
	local stage = Scene.STAGE_CHAPTER
	local scene = cc.Scene:create()
	local layer_list = {}
	local layer

	layer = LayerNet:create()
	scene:addChild(layer, Touch.ZORDER_LAYER_NET)
	table.insert(layer_list, layer)

	layer = SceneChapter:create()
	scene:addChild(layer, Touch.ZORDER_LAYER_CHAPTER)
	table.insert(layer_list, layer)

	layer = LayerInfoBar:create()
	scene:addChild(layer, Touch.ZORDER_LAYER_INFOBAR)
	table.insert(layer_list, layer)

	layer = LayerTouch:create()
	scene:addChild(layer, Touch.ZORDER_LAYER_TOUCH)
	table.insert(layer_list, layer)

	Scene:changeScene(scene, stage, layer_list)

	-- should not show loading,
	-- when scene change, the pointer to loading will still here and cause bug
	--net_send('lchapter', true);
	--net_send('chapter_data 0', true);
	local cid = layer_chapter.last_chapter_id or 0;
	get_chapter_data(cid, true);
end

function SceneChapter:ctor(...)
	self:initLayer(...)
end

function SceneChapter:initLayer(callback, action, res_stage)
	self._name = Info.LAYER_CHAPTER

	Touch.regHandler(self, -Touch.ZORDER_LAYER_CHAPTER, handler(self, self.handler), true)

	self._last_chapter_id = nil -- mark last operate, will reset when logout
	self._is_in_last_stage = nil -- jump to next chapter or not
	self._set_stage_id_for_mission = nil
	self._stage_num = nil
	self._chapter_id = nil
	self._total_chapter_size = nil
	self._list = nil
	self._map = nil
	self._title = nil
	self._hl = nil
	self._arrow = nil
	self._hlscale = nil
	self._arrowscale = nil
	self._left_arrow = nil
	self._right_arrow = nil
	self._select_info = nil
	self._tx = nil
	self._big_box_scale = nil
	self._big_box = nil
	self._big_box_mission = nil

	self._list = {}
	--GUI.addLayerColor(self, cc.c4b(0, 0, 0, 150))

	local map, title, data
	map, title = initChapterBgFull(self, GUI.GUI_CHAPTER, handler(self, self.back), "")
	self._map = map
	self._title = title
	
	local items = {}

	local map_data = GUI.getData('map', GUI.GUI_CHAPTER, GUI.ANCHOR_DOWN)
	local tower, star, box, label, key, str
	self._big_box = GUI.addItemOnCell(items, map_data, "box", GUI.GUI_CHAPTER, handler(self, self.cbBigBox), GUI.ANCHOR_DOWN)
	self._big_box_scale = self._big_box:getScale()
	self._big_box:setOpacity(0)
	self._big_box_mission = nil
	local path = Util.getPath(Util.FT_7)
	for i = 1, 9 do
		key = 'b' .. i
		box, data = GUI.addItemOnCell(items, map_data, key, GUI.GUI_CHAPTER, handler(self, self.cbBox), GUI.ANCHOR_DOWN)
		box:setTag(i)

		key = 'star' .. i
		star, data = GUI.addSpriteOnCellByData(map, map_data, key, GUI.GUI_CHAPTER, GUI.ANCHOR_DOWN)
		key = 'tower' .. i
		tower, data = GUI.addItemOnCell(items, map_data, key, GUI.GUI_CHAPTER, handler(self, self.cbTower), GUI.ANCHOR_DOWN)
		tower:setTag(i)

		pos = cc.p(data.x+data.width/2, data.y+8)
		str = ""
		label=GUI.addLabelBMF(map,str,path,pos,GUI.ANCHOR_CENTER_DOWN, data.zorder+10)

		box:setOpacity(0)
		tower:setOpacity(0)
		star:setOpacity(0)
		label:setOpacity(0)
		table.insert(self.list, { 
			tower = tower, star = star, label = label, box = box,
			tower_scale = tower:getScale(), star_scale = star:getScale(),
			label_scale = label:getScale(), box_scale = box:getScale(),
		})
	end
	GUI.addMenu(map, items, data.zorder)

	path = Util.getPath('pic_76.png')
	self._hl = GUI.addSprite(map, path, cc.p(0, 0), GUI.ANCHOR_CENTER_CENTER, data.zorder-1)
	self._hl:setOpacity(0)
	path = Util.getPath('pic_75.png')
	self._arrow = GUI.addSprite(map, path, cc.p(0, 0), GUI.ANCHOR_CENTER_CENTER, data.zorder+10)
	self._arrow:setOpacity(0)
	self._hlscale = self._hl:getScale()
	self._arrowscale = self._arrow:getScale()
	local array, action
	array = {}
	action = CCMoveBy:create(0.6, cc.p(0, -GUI.hfix(13)))
	table.insert(array, action)
	action = action:reverse()
	table.insert(array, action)
	action = CCSequence:create(array)
	action = CCRepeatForever:create(action)
	self._arrow:runAction(action)

	items = {}
	self._right_arrow, data = GUI.addItemByData(items, 'arrow_right', GUI.GUI_CHAPTER, handler(self, self.right))
	self._left_arrow, data = GUI.addItemByData(items, 'arrow_left', GUI.GUI_CHAPTER, handler(self, self.left))
	self._left_arrow:setVisible(false)
	self._right_arrow:setVisible(false)
	GUI.addMenu(self, items, data.zorder)

	self:setArrowMoveAction(self._left_arrow, GUI.wfix(-20))
	self:setArrowMoveAction(self._right_arrow, GUI.wfix(20))
end

function SceneChapter:handler(event, x, y)
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
		self:back()
	end
end

function SceneChapter:onTouchBegan(x, y)
	self._tx = x
	return true
end
	
function SceneChapter:onTouchMoved(x, y)
	
end
	
function SceneChapter:onTouchEnded(x, y)
	self._tx = self._tx or x
	local offset = self._tx - x
	if offset < -GUI.HALF_WIDTH/2 then
		self:left()
		return
	end
	if offset > GUI.HALF_WIDTH/2 then
		self:right()
		return
	end
end

function SceneChapter:cleanup()
	self._last_chapter_id = nil -- mark last operate, will reset when logout
	self._is_in_last_stage = nil -- jump to next chapter or not
	self._set_stage_id_for_mission = nil
	self._stage_num = nil
	self._chapter_id = nil
	self._total_chapter_size = nil
	self._list = nil
	self._map = nil
	self._title = nil
	self._hl = nil
	self._arrow = nil
	self._hlscale = nil
	self._arrowscale = nil
	self._left_arrow = nil
	self._right_arrow = nil
	self._select_info = nil
	self._tx = nil
	self._big_box_scale = nil
	self._big_box = nil
	self._big_box_mission = nil
end

function SceneChapter:remove()
	Scene:removeLayer(self)
end

function SceneChapter:initChapterBgFull(layer, ltype, cb_back, title)
	local sprite, data, d2, size, item, map;
	sprite, data = GUI.addSpriteByData(layer, 'bg_wall', ltype, GUI.ANCHOR_DOWN)
	d2 = GUI.getData('bg_wall', ltype, GUI.ANCHOR_UP)
	sprite:setContentSize(cc.size(data.width, d2.y+d2.height-data.y))
	sprite, data = GUI.addSpriteByData(layer, 'bg', ltype)
	if data.width/data.rwidth > data.height/data.rheight then
		sprite:setScale(data.width/data.rwidth)
	else
		sprite:setScale(data.height/data.rheight)
	end
	GUI.addSpriteByData(layer, 'leaf_left_up', ltype, GUI.ANCHOR_UP)
	GUI.addSpriteByData(layer, 'leaf_right_down', ltype, GUI.ANCHOR_DOWN)
	sprite, data = GUI.addSpriteByData(layer, 'bg_map', ltype, GUI.ANCHOR_DOWN)
	d2 = GUI.getData('bg_map', ltype, GUI.ANCHOR_UP)
	sprite:setScaleX((d2.x+d2.width-data.x)/data.rwidth)
	sprite:setScaleY((d2.y+d2.height-data.y)/data.rheight)

	map, data = GUI.addSpriteByData(layer, 'map', ltype, GUI.ANCHOR_DOWN)
	d2 = GUI.getData('map', ltype, GUI.ANCHOR_UP)
	local width = data.width
	local height = d2.y+d2.height-data.y
	local wscale = map:getScale()
	local hscale = height/data.height
	if wscale > hscale then
		-- size like ipad, width is bigger, so move x
		local nx = data.x + data.width/2 - data.rwidth*hscale/2
		local ny = data.y
		map:setPosition(cc.p(nx, ny))
		map:setScale(hscale)
	elseif wscale < hscale then
		-- size like iphone5, height is bigger, so move y
		local nx = data.x
		local ny = data.y - data.height/2 + data.rheight*hscale/2
		map:setPosition(cc.p(nx, ny))
		map:setScale(wscale)
	end

	GUI.addSpriteByData(layer, 'bg_title', ltype, GUI.ANCHOR_UP)
	local title = GUI.addLabelAliByData(layer, title, 28, 'title', ltype, GUI.ANCHOR_UP, cc.TEXT_ALIGNMENT_CENTER)

	if nil == cb_back then return end
	local items = {}
	item, data = GUI.addItemByData(items, 'btn_back', ltype, cb_back, GUI.ANCHOR_UP)
	GUI.addMenu(layer, items, data.zorder)
	return map, title
end

function SceneChapter:back()
	Audio.playTap1()
	--g_scene:go(GUI_MAIN, "map");
	Scene:showMap()
end

function SceneChapter:setArrowMoveAction(arrow, dis)
	local array, action
	array = {}
	action = CCMoveBy:create(0.8, cc.p(dis, 0))
	table.insert(array, action)
	action = action:reverse()
	table.insert(array, action)
	action = CCSequence:create(array)
	action = CCRepeatForever:create(action)
	arrow:runAction(action)
end

function SceneChapter:setTitle(chapter_id, chapter_name, total_chapter_size)
	-- chapter_id also means chapter_pos
	self._chapter_id = chapter_id
	self._total_chapter_size = total_chapter_size
	self._title:setString(string.format("第%d章 %s", chapter_id,chapter_name))
	if chapter_id == 1 then
		self._left_arrow:setVisible(false)
		self._right_arrow:setVisible(true);
	elseif chapter_id == total_chapter_size then
		self._left_arrow:setVisible(true)
		self._right_arrow:setVisible(false)
	else
		self._left_arrow:setVisible(true)
		self._right_arrow:setVisible(true)
	end
end

function SceneChapter:getTitleString()
	if nil == self._title then return end
	return self._title:getString()
end

function SceneChapter:setListTower(clist)
	clist = clist or {}
	self._stage_num = #clist
	self._list = self._list or {}
	Anim.stopKeffShowUp1(self._hl, self._hlscale)
	Anim.stopKeffShowUp1(self._arrow, self._arrowscale)
	local bscale = self._big_box_scale
	Anim.stopKeffShowUp1(self._big_box, bscale)
	self.big_box:setOpacity(0)
	local has_set_flag = false -- not fight
	for i = 1, #self._list do
		local info = self._list[i]
		local cinfo = clist[i]
		local tscale = info.tower_scale
		local sscale = info.star_scale
		local lscale = info.label_scale
		local bscale = info.box_scale
		Anim.stopKeffShowup1(info.tower, tscale)
		Anim.stopKeffShowup1(info.star, sscale)
		Anim.stopKeffShowup1(info.label, lscale)
		Anim.stopKeffShowup1(info.box, bscale)
		info.tower:setOpacity(0)
		info.star:setOpacity(0)
		info.label:setOpacity(0)
		info.box:setOpacity(0)
		if nil ~= cinfo then
			info.data = cinfo
			info.label:setString(string.format("%d-%d", self._chapter_id or 0, i))
			local flag = cinfo.flag
			-- 0,1,2,3==finish and star num, 8==not fight 9==lock
			local fname = nil
			if 0 == flag or 8 == flag or 9 == flag then
				fname = 'pic_67.png'
			elseif 1 == flag then
				fname = 'pic_65.png'
			elseif 2 == flag then
				fname = 'pic_66.png'
			elseif 3 == flag then
				fname = 'pic_64.png'
			end
			if nil ~= fname then
				local path = Util.getPath(fname)
				local tc = cc.Director:getInstance():getTextureCache()
				local texture = tc:addImage(path)
				if nil == texture then return end
				info.star:setTexture(texture)
			end
			local delay = ((i-1)%10)*0.1
			if (nil ~= cinfo.stage_id and cinfo.stage_id == self._set_stage_id_for_mission) or  (false == has_set_flag and 8 == flag) then
				local x, y = info.tower:getPosition()
				local size = info.tower:getContentSize()
				local scale = tscale
				x = x + size.width*scale/2
				y = y + size.height*scale/2
				self._hl:setPosition(cc.p(x, y))
				self._hl:setScale(scale)
				self._hl:setOpacity(255)
				self._arrow:setPosition(cc.p(x, y+50*scale))
				self._arrow:setScale(scale)
				self._arrow:setOpacity(255)
				Anim.keffShowUp1(self._hl, delay+0.15)
				Anim.keffShowUp1(self._arrow, delay+0.2)
				has_set_flag = true
				self._set_stage_id_for_mission = nil
			end
			Anim.keffShowUp1(info.tower, delay, nil, tscale)
			Anim.keffShowUp1(info.label, delay+0.1, nil, lscale)
			if 9 ~= flag then
				Anim.keffShowUp1(info.star, delay+0.1, nil, sscale)
			else
				Anim.stopKeffShowUp1(info.star, sscale)
			end
		end
	end
	if false == has_set_flag then
		self._hl:setOpacity(0)
		self._arrow:setOpacity(0)
	end
end

function SceneChapter:setMList(list)
	list = list or {}
	self._list = self._list or {}
	for i = 1, #self._list do
		local info = self._list[i]
		local data = self._list[i].data
		if nil ~= data then
			local stage_id = data.stage_id
			local bscale = info.box_scale
			Anim.stopKeffShowUp1(info.box, bscale)
			info.box:setOpacity(0)
			local delay = ((i-1)%10)*0.1
			for j = 1, #list do
				local minfo = list[j]
				--local chapter_id = minfo.p2;
				local mtype = minfo.mtype
				local sid = minfo.p3
				if mtype == MISSION_CHAPTER_STAGE and sid == stage_id then
					info.mdata = minfo;
					local data = nil;
					if 3 == minfo.status then
						data = gui_get_data('b1_open',GUI_CHAPTER,ANCHOR_UP);
					else
						data = gui_get_data('b1',GUI_CHAPTER,ANCHOR_UP);
					end
					local path1 = util.get_path(data.fname1);
					local path2 = util.get_path(data.fname2);
					info.box:setNormalImage(util.create_sprite(path1));
					info.box:setSelectedImage(util.create_sprite(path2));
					keff_showup_1(info.box, delay, nil, bscale);
					break;
				end
			end
		end
	end
	local bscale = self.big_box_scale;
	stop_keff_showup_1(self.big_box, bscale);
	self.big_box:setOpacity(0);
	for i = 1, #list do
		local minfo = list[i];
		local mtype = minfo.mtype;
		if mtype == MISSION_CHAPTER then
			local data = nil;
			if 3 == minfo.status then
				data = gui_get_data('box_open',GUI_CHAPTER,ANCHOR_UP);
			else
				data = gui_get_data('box',GUI_CHAPTER,ANCHOR_UP);
			end
			local path1 = util.get_path(data.fname1);
			local path2 = util.get_path(data.fname1);
			self.big_box:setNormalImage(util.create_sprite(path1));
			self.big_box:setSelectedImage(util.create_sprite(path2));
			keff_showup_1(self.big_box, 0, nil, bscale);
			self.big_box_mission = minfo;
		end
	end
	-- tutor
	if true == util.trigger_tutor(TUTOR_CHAPTER_1_1) then
		return;
	end
	if true == util.trigger_tutor(TUTOR_CHAPTER_1_1_R) then
		return;
	end
	if true == util.trigger_tutor(TUTOR_CHAPTER_1_2) then
		return;
	end
	if true == util.trigger_tutor(TUTOR_CHAPTER_1_2_R) then
		return;
	end
	if true == util.trigger_tutor(TUTOR_CHAPTER_1_3) then
		return;
	end
	if true == util.trigger_tutor(TUTOR_CHAPTER_1_3_R) then
		return;
	end
	if true == util.trigger_tutor(TUTOR_RETURN_1_1) then
		return;
	end
	if true == tutor_chapter_1_4() then
		return;
	end
	if true == tutor_chapter_1_4_r() then
		return;
	end
	if true == tutor_chapter_1_5() then
		return;
	end
	if true == tutor_chapter_1_5_r() then
		return;
	end
	if true == tutor_chapter_1_6() then
		return;
	end
	if true == tutor_chapter_1_6_r() then
		return;
	end
	if true == tutor_chapter_1_7() then
		return;
	end
	if true == tutor_chapter_1_7_r() then
		return;
	end
	if true == util.trigger_tutor(TUTOR_RETURN_1_7) then
		return;
	end
	if true == tutor_chapter_1_8() then
		return;
	end
	if true == tutor_chapter_1_8_r() then
		return;
	end
	if true == util.trigger_tutor(TUTOR_RETURN_1_8) then
		return;
	end
	if true == util.trigger_tutor(TUTOR_CHAPTER_1_9) then
		return;
	end
	if true == util.trigger_tutor(TUTOR_RETURN_1_9) then
		return;
	end
end,

left = function()
	local self = layer_chapter;
	local cid = self.chapter_id;
	cid = cid - 1;
	if cid < 1 then
		cid = 1;
	end
	--net_send(string.format("chapter_data %d", cid), true);
	get_chapter_data(cid, true);
end,

right = function()
	local self = layer_chapter;
	local cid = self.chapter_id;
	cid = cid + 1;
	if cid > self.total_chapter_size then
		cid = self.total_chapter_size;
	end
	--net_send(string.format("chapter_data %d", cid), true);
	get_chapter_data(cid, true);
end,

get_select_info = function(self)
	return self.select_info;
end,

choose_tower = function(self, index)
	play_tap_1();
	local info = self.list[index];
	self.select_info = info;
	if nil == info then return; end
	local cid = self.chapter_id;
	local sid = info.data.stage_id;
	local flag = info.data.flag;
	if nil == cid or nil == sid then
		return;
	end
	if 9 == flag then
		show_msg("关卡未开放");
		return;
	end
	if index == self.stage_num then
		self.is_in_last_stage = true;
	else
		self.is_in_last_stage = false;
	end
	net_send(string.format("chapter_stage %d %d", cid, sid));
end,

cb_tower = function(...)
	local self = layer_chapter;
	local args = {...};
	local index = args[2]:getTag();
	self:choose_tower(index);
end,

choose_box = function(self, index)
	play_tap_1();
	local minfo = self.list[index].mdata;
	if nil == minfo then return; end
	g_scene:add_layer(ZORDER_LAYER_CBOX, layer_cbox:create(minfo));
end,

cb_box = function(...)
	local self = layer_chapter;
	local args = {...};
	local index = args[2]:getTag();
	self:choose_box(index);
end,

cb_bigbox = function(...)
	local self = layer_chapter;
	local args = {...};
	local index = args[2]:getTag();
	local minfo = self.big_box_mission;
	if nil == minfo then return; end
	g_scene:add_layer(ZORDER_LAYER_CBOX, layer_cbox:create(minfo));
	local cid = self.chapter_id;
	local items = {};
	local pos = cc.p(wfix(560)/2+160, 28);
	local item=add_item_1(items,'首充',nil,30,go_pay,ANCHOR_CENTER_DOWN,pos);
	util.add_menu(layer_cbox.bg, items, 60);
end,

return SceneChapter

