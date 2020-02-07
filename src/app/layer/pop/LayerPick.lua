local Info = require("app.base.Info")
local GUI = require("app.base.GUI")
local Audio = require("app.base.Audio")
local Touch = require("app.base.Touch")
local Scene = require("app.base.Scene")

local LayerPick = class("LayerPick", cc.Layer)

function LayerPick:ctor(list, cb)
	self._name = Info.LAYER_PICK

	self._list = list or {}
	self._callback = cb
	self._cwidth = nil
	self._cheight = nil
	self._data_cell = nil
	self._bar = nil
	self._tap = nil
	self._do_cell_anim = nil

	GUI.addLayerColor(self, cc.c4b(0, 0, 0, 128))

	Touch.regHandler(self, -Touch.ZORDER_LAYER_PICK, handler(self, self.handler), true)

	self:init()
end

function LayerPick:handler(event, x, y)
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
		self:close()
	end
end

function LayerPick:onTouchBegan(x, y)
	return true
end
	
function LayerPick:onTouchMoved(x, y)
end
	
function LayerPick:onTouchEnded(x, y)
	self._do_cell_anim = false
end

function LayerPick:remove()
	Scene:removeLayer(self)
end

function LayerPick:close()
	Audio.playTap1()
	self:remove()
end

function LayerPick:cleanup()
	self._list = nil
	self._callback = nil
	self._cwidth = nil
	self._cheight = nil
	self._data_cell = nil
	self._bar = nil
	self._tap = nil
	self._do_cell_anim = nil
end

function LayerPick:init()
	local bg, sprite, data, data2, fullpath, pos, size, width, height
	bg, data = GUI.addSpriteByData(self, 'pbg', GUI.GUI_DECK, GUI.ANCHOR_DOWN)
	data2 = GUI.getData('pbg', GUI.GUI_DECK, GUI.ANCHOR_UP)
	local offsety = data2.y - data.y
	bg:setContentSize(cc.size(data.width, data.height + offsety))
	GUI.addSpriteByData(self, 'ptip', GUI.GUI_DECK, GUI.ANCHOR_UP)
	sprite, data = GUI.addSpriteByData(self, 'pframe', GUI.GUI_DECK, GUI.ANCHOR_DOWN)
	sprite:setContentSize(cc.size(data.width, data.height + offsety))

	self._do_cell_anim = true
	data = GUI.getData('pcell', GUI.GUI_DECK, GUI.ANCHOR_DOWN)
	self._data_cell = data
	self._cwidth = data.width
	self._cheight = data.height
	data = GUI.getData('ptable', GUI.GUI_DECK, GUI.ANCHOR_DOWN)
	pos = cc.p(data.x, data.y)
	size = cc.size(data.width, data.height + offsety)
	-----
	self._bar, self._tap = GUI.addTableViewScrollBar(self, cc.p(pos.x+size.width, pos.y), size, GUI.ANCHOR_LEFT_DOWN, data.zorder+4)
	-----
	self.tableview = GUI.addTableView(self, size, cc.SCROLLVIEW_DIRECTION_VERTICAL, handler(self, self.tableviewHandler), pos, cc.TABLEVIEW_FILL_TOPDOWN,data.zorder)

	local items = {}
	local item

	item, data2 = GUI.addItemByData(items, 'pbtn_back', GUI.GUI_DECK, handler(self, self.close), GUIANCHOR_UP)

	GUI.addMenu(self, items, data2.zorder)
end

function LayerPick:tableviewHandler(...) -- { start
	local args = {...}
	local event = args[1]
	local view = args[2]
	--kdebug("%s", event)
	if "numberOfCellsInTableView" == event then
		return #(self._list or {})
	elseif "scrollViewDidScroll" == event then
		GUI.handleTableViewScrollBar(view, self._bar, self._tap)
		return
	elseif "scrollViewDidZoom" == event then
		return
	elseif "tableCellTouched" == event then
		local cell = args[3]
		local idx = cell:getIdx()
		if nil ~= self._callback then
			local info = self._list[idx + 1]
			local tag = info.tag
			self._callback(tag)
		end
		self:close()
		return 0
	elseif "cellSizeForTable" == event then
		local idx = args[3]
		return self.cheight, self.cwidth
	elseif "tableCellAtIndex" == event then
		local idx = args[3]
		local cell = view:dequeueCell()
		if nil ~= cell then
			cell:removeFromParentAndCleanup(true)
		end
		cell = cc.TableViewCell:new()
		local data = self._data_cell
		local bg = GUI.addCellBg(cell, data)
		bg:setTag(GUI.TAG_CELL_BG)
		local width = self._cwidth
		local height = self._cheight
		local info = self._list[idx + 1]
		local str = info.title
		GUI.addLabelOnCell(cell,data,str,24,'pstr',GUI.GUI_DECK,GUI.ANCHOR_DOWN)

		if nil ~= info.btn1 and nil ~= info.btn2 and nil ~= info.callback then
			local items = {}
			local item;
			local function cb()
				info.callback(info.tag)
				self:close()
			end

			local fname1 =Util.getPath(info.btn1)
			local fname2 =Util.getPath(info.btn2)
			pos = cc.p(width-80, height/2)
			item = GUI.createItemImage(fname1, fname2, pos, GUI.ANCHOR_LEFT_CENTER, cb)
			table.insert(items, item)

			GUI.addMenu(cell, items, 80)
		end
		if true == self._do_cell_anim then
			local delay = (idx%10)*0.1
			GUI.keffShowFromRight(cell, delay)
		end
		return cell
	elseif "tableCellHighlight" == event then
		local cell = args[3]
		local sprite = cell:getChildByTag(GUI.TAG_CELL_BG)
		if nil ~= sprite then
			local data = self._data_cell
			local path = Util.getPath(data.fname2)
			local tc = cc.Director:getInstance():getTextureCache()
			local texture = tc:addImage(path)
			if nil == texture then return end
			sprite:setTexture(texture)
		end
		return
	elseif "tableCellUnhighlight" == event then
		local cell = args[3]
		local sprite = cell:getChildByTag(GUI.TAG_CELL_BG)
		if nil ~= sprite then
			local data = self._data_cell
			local path = Util.getPath(data.fname1)
			local tc = cc.Director:getInstance():getTextureCache()
			local texture = tc:addImage(path)
			if nil == texture then return end
			sprite:setTexture(texture)
		end
		return
	end
end -- tableview_handler end }

return LayerPick

