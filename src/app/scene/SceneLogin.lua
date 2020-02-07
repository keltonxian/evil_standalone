local Info = require("app.base.Info")
local Util = require("app.base.Util")
local GUI = require("app.base.GUI")
local Audio = require("app.base.Audio")
local Touch = require("app.base.Touch")
local Scene = require("app.base.Scene")
local Net = require("app.base.Net")
local LayerNet = require("app.layer.net.LayerNet")
local LayerTouch = require("app.layer.touch.LayerTouch")

local SceneLogin = class("SceneLogin", cc.Layer)

function SceneLogin.showScene()
	local stage = Scene.STAGE_LOGIN
	local scene = cc.Scene:create()
	local layer_list = {}
	local layer

	layer = LayerNet:create()
	scene:addChild(layer, Touch.ZORDER_LAYER_NET)
	table.insert(layer_list, layer)

	layer = SceneLogin:create()
	scene:addChild(layer, Touch.ZORDER_LAYER_LOGIN)
	table.insert(layer_list, layer)

	layer = LayerTouch:create()
	scene:addChild(layer, Touch.ZORDER_LAYER_TOUCH)
	table.insert(layer_list, layer)

	Scene:changeScene(scene, stage, layer_list)

	Scene:closeConnect()
end

function SceneLogin:ctor(...)
	--[[ now do in version.lua
	IP_ADDR = util.load_rms('ip_addr', 'string') or ''
	if '' == IP_ADDR then
		local server_list = util.load_server()
		if 0 < #server_list then
			IP_ADDR = server_list[1].ip
		end
	end
	]]--
	Util.log(">>>>>>>>>>> game ip [%s] <<<<<<<<<<<<", IP_ADDR)
	Util.saveRms('re_update_lua', 'no', 'string')
	--LayerSocket:initSocketRes(IP_ADDR);
	self:gameInitialize()
	self:initLayer(...)
end

function SceneLogin:gameInitialize()
	local dic = cc.FileUtils:getInstance():getValueMapFromFile("game_config.plist")
	Info.CPID = dic["CPID"]
	Info.CHANNEL_VER = dic["CHANNEL_VER"]
	if true == Info.isVer(Info.VER_APPSTORE) then
		local args = {}
		local luaoc = require "luaoc"
		local class_name = "IAPView"
		local ok, ret = luaoc.callStaticMethod(class_name, "checkIAPClear", args)
	end
	-- main_init
	Audio.loadVolume()

	local path = Util.getFullPath(Util.F_SOUND, 'tap_1.mp3')
	Audio.preloadEffect(path)
	path = Util.getFullPath(Util.F_SOUND, 'tap_2.mp3')
	Audio.preloadEffect(path)
	path = Util.getFullPath(Util.F_SOUND, 'tap_3.mp3')
	Audio.preloadEffect(path)
	path = Util.getFullPath(Util.F_SOUND, 'turn_card.mp3')
	Audio.preloadEffect(path)

	Util.initLang()

	GUI.init()

	Util.loadSensitiveData()
end

function SceneLogin:initLayer(...)
	self._name = Info.LAYER_LOGIN

	self._username = ''
	self._password = ''
	self._toggle_info = nil
	self._server_list = nil
	self._ip_addr = ''
	self._btn_cserver = nil
	self._t_server = nil
	self._is_changed = nil

	Touch.regHandler(self, -Touch.ZORDER_LAYER_LOGIN, handler(self, self.handler), true)

	self._server_list = Net:loadServer()
	self:init()
end

function SceneLogin:handler(event, x, y)
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
		if nil ~= layer_register.layer then
			layer_register.close()
			return
		end
		ask_exit()
	end
end

function SceneLogin:onTouchBegan(x, y)
	return true
end
	
function SceneLogin:onTouchMoved(x, y)
	
end
	
function SceneLogin:onTouchEnded(x, y)

end

function SceneLogin:remove()
	Scene:removeLayer(self)
end

function SceneLogin:cleanup()
	self._username = nil
	self._password = nil
	self._toggle_info = nil
	self._server_list = nil
	self._ip_addr = nil
	self._btn_cserver = nil
	self._t_server = nil
	self._is_changed = nil
end

function SceneLogin:init()
	self._is_changed = false
	local data, pos, sprite, size
	sprite,data = GUI.addSpriteByData(self, 'bg', GUI.GUI_LOGIN)
	if data.width/data.rwidth > data.height/data.rheight then
		sprite:setScale(data.width/data.rwidth)
	else
		sprite:setScale(data.height/data.rheight)
	end
	sprite,data = GUI.addSpriteByData(self, 'building', GUI.GUI_LOGIN, GUI.ANCHOR_DOWN)
	sprite,data = GUI.addSpriteByData(self, 'logo', GUI.GUI_LOGIN, GUI.ANCHOR_UP)
	local bg, bdata = GUI.addSpriteByData(self, 'frame', GUI.GUI_LOGIN, GUI.ANCHOR_UP)
	local y = GUI.HALF_HEIGHT - GUI.wfix(44)
	bg:setPositionY(y)
	y = y + bdata.height / 2 + GUI.wfix(44)
	if (y + data.height + GUI.wfix(5)) > GUI.FULL_HEIGHT then
		y = GUI.FULL_HEIGHT - data.height - GUI.wfix(5)
	end
	sprite:setPositionY(y)
	bg:setAnchorPoint(GUI.ANCHOR_LEFT_CENTER)
	sprite = GUI.addStrokeAliOnCell(bg, bdata, '登录', 30, 'title', GUI.GUI_LOGIN, GUI.ANCHOR_UP, cc.TEXT_ALIGNMENT_CENTER)

	local str = Util.lText("USERNAME")
	GUI.addStrokeOnCellByData(bg, bdata, str, 30, 't_uname', GUI.GUI_LOGIN, GUI.ANCHOR_UP)
	GUI.addSpriteOnCellByData(bg,bdata, 'bg_uname', GUI.GUI_LOGIN, GUI.ANCHOR_UP)

	str = Util.lText("PASSWORD")
	GUI.addStrokeOnCellByData(bg, bdata, str, 30, 't_pw', GUI.GUI_LOGIN, GUI.ANCHOR_UP)
	GUI.addSpriteOnCellByData(bg, bdata, 'bg_pw', GUI.GUI_LOGIN, GUI.ANCHOR_UP)

	local color
	data = GUI.getDataOnCell(bdata, 'uname', GUI.GUI_LOGIN, GUI.ANCHOR_UP)
	color = cc.c3b(data.r, data.g, data.b)
	-- editbox username
	pos = cc.p(data.x, data.y + data.height / 2)
	size = cc.size(data.width, data.height)
	self._username = GUI.addEditBoxBlank(bg, size, 
		GUI.ANCHOR_LEFT_CENTER, pos, GUI.f_default, 20, color, 
		cc.EDITBOX_INPUT_MODE_SINGLELINE, cc.KEYBOARD_RETURNTYPE_DONE, 
		nil, handler(self, self.editBoxHandler), 30, Util.lText("LOG_TIP_UNAME"), 
		GUI.c_gray, data.zorder)
	local has_u = false
	local u = Util.loadRms('username', 'string')
	if nil ~= u and '' ~= u then
		self._username:setText(u)
		has_u = true
	end

	-- editbox password
	data = GUI.getDataOnCell(bdata, 'pw', GUI.GUI_LOGIN, GUI.ANCHOR_UP)
	color = cc.c3b(data.r, data.g, data.b)
	pos = cc.p(data.x, data.y + data.height / 2)
	size = cc.size(data.width, data.height)
	self._password = GUI.addEditBoxBlank(bg, size, GUI.ANCHOR_LEFT_CENTER,
		pos, GUI.f_default, 20, color, cc.EDITBOX_INPUT_MODE_SINGLELINE,
		cc.KEYBOARD_RETURNTYPE_DONE, cc.EDITBOX_INPUT_FLAG_PASSWORD, 
		handler(self, self.editBoxHandler), 30, Util.lText("LOG_TIP_PW"), 
		GUI.c_gray, data.zorder)
	-- TODO fix samsung, do not use kEditBoxInputFlagPassword, 
	-- also: use kEditBoxInputModeSingleLine (so that ENTER button not work)

	local has_p = false
	local p = Util.loadRms('password', 'string')
	if nil ~= p and '' ~= p then
		self._password:setText(p)
		has_p = true
	end

	str = Util.lText("LOG_TIP_SAVE")
	GUI.addLabelOnCell(bg, bdata, str, 20, 'tip_save', GUI.GUI_LOGIN, GUI.ANCHOR_UP)

	local items = {}
	local item

	-- self.toggle_info:getSelectedIndex()  0 : off     1 : on
	item, data = GUI.addItemOnCell(items, bdata, 'toggle', GUI.GUI_LOGIN, handler(slef, self.callbackSaveInfo), GUI.ANCHOR_UP)
	self._toggle_info = item
	-- if has_u == false , it means first run this app, so should set toggle
	-- then app will remember username every time
	if false == has_u or true == has_p then
		self._toggle_info:setSelectedIndex(1)
	end

	item,data = GUI.addItemOnCell(items, bdata, 'login', GUI.GUI_LOGIN,
		handler(self, self.cbLogin), GUI.ANCHOR_UP)
	GUI.addTextOnSprite(item, "登录", 't_login', GUI.GUI_LOGIN, GUI.ANCHOR_UP, 30)
	
	item,data = GUI.addItemOnCell(items, bdata, 'reg', GUI.GUI_LOGIN, handler(self, self.cbReg), GUI.ANCHOR_UP)
	GUI.addTextOnSprite(item, "注册", 't_reg', GUI.GUI_LOGIN, GUI.ANCHOR_UP, 30)

	item,data = GUI.addItemOnCell(items, bdata, 'more', GUI.GUI_LOGIN, handler(self, self.userList), GUI.ANCHOR_UP)

	-- ip info start
	local ipstr = Net:getServerName(self._server_list, Info.IP_ADDR)
	print ('ipstr: ' .. ipstr)
	item,data=GUI.addItemOnCell(items,bdata,'server',GUI.GUI_LOGIN,handler(self,self.cbServer),GUI.ANCHOR_UP)
	self._btn_cserver = item
	GUI.addLabelOnCell(bg, bdata, '点击换区', 24, 't_server_right', GUI.GUI_LOGIN, GUI.ANCHOR_UP)
	self._t_server = GUI.addLabelOnCell(bg,bdata, ipstr, 24, 't_server_left', GUI.GUI_LOGIN, GUI.ANCHOR_UP)

	GUI.addMenu(bg, items, data.zorder)

	pos = cc.p(0, 0)
	str = Util.getClientVersion()
	Util.log('        =========client version : ' .. str)
	GUI.addLabelTTF(self, str, nil, 30, pos, GUI.c4b_white, GUI.ANCHOR_LEFT_DOWN, 100)
end

function SceneLogin:editBoxHandler(eventname, psender)
	local edit = tolua.cast(psender, "cc.EditBox")
	if eventname == "began" then
	elseif eventname == "ended" then
	elseif eventname == "return" then
		--str = string.format("editbox %p was returned !",edit)
		--print('DEBUG ', str);
		--[[
		if self.username == edit then
			local s = edit:getText();
			if nil == s or '' == s then
				edit:setPlaceHolder('username');
			end
		elseif self.password == eidt then
			local s = edit:getText();
			if nil == s or '' == s then
				edit:setPlaceHolder('password');
			end
		end
		]]--
		if edit == self.username and nil ~= self.password then
			--self.password:sendActionsForControlEvents(cc.CONTROL_EVENTTYPE_TOUCH_UP_INSIDE);
		end
	elseif eventname == "changed" then
	end
end

function SceneLogin:cbLogin()
	Audio.playTap1()
	Util.LOCAL_TEST = false
	--[[ do in change_server
	if false == self:check_ip() then
		return;
	end
	--]]
	self:saveIP()
	--print('DEBUG callback_login');
	-- self.toggle_info:getSelectedIndex()  0 : off     1 : on
	local toggle_index = self._toggle_info:getSelectedIndex()
	local username = self._username:getText()
	local password = self._password:getText()
	if 0 == toggle_index then
		Util.removeRms('password')
	end
	if nil == username or '' == string.gsub(username, "^%s*(.-)%s*$", "%1") then
		local layer = require("app.layer.pop.LayerMsg"):create('ERROR 请填写用户名')
		Scene:addLayer(Touch.ZORDER_LAYER_MSG, layer, true)
		return
	end
	if nil == password or '' == string.gsub(password, "^%s*(.-)%s*$", "%1") then
		local layer = require("app.layer.pop.LayerMsg"):create('ERROR 请填写密码')
		Scene:addLayer(Touch.ZORDER_LAYER_MSG, layer, true)
		return
	end
	--[[
	local ret
	ret = g_scene:connect_to_net()
	if ret <= 0 then
		return
	end
	g_euser.username = username;
	net_cmd_log(username, password);
	--]]
end

function SceneLogin:saveIP()
	Util.saveRms('ip_addr', Info.IP_ADDR, 'string')
end

function SceneLogin:checkIP()
	local ip = Util.loadRms('ip_addr', 'string') or ''
	if true == self._is_changed and Info.IP_ADDR ~= ip then
		self:saveIP()
		Util.saveRms('re_update_lua', 'yes', 'string')
		Util.saveRms(Util.KEY_PATCH_INDEX, Util.CLIENT_PATCH, 'integer')
		Util.deleteDownloadResource()
		Util.relaunchGame()
		return false
	end
	return true
end

function SceneLogin:cbReg()
	Audio.playTap1()
	if false == self:checkIP() then
		return
	end
	self:saveIP()
	g_scene:add_layer(Touch.ZORDER_LAYER_REGISTER, layer_register:create())
end

function SceneLogin:userList(...)
	Audio.playTap1()
	local arg = { ... }
	local item = arg[2]
	local pos = cc.p(item:getPositionX(), item:getPositionY())
	local size = item:getContentSize()
	local cb = handler(self, self.callbackUser)
	local str_list = Util.loadRms('user_list', 'string')
	local list = Util.splitString(str_list)
	local nlist = {};
	for i = 1, #list do
		table.insert(nlist, { tag = i, title=list[i], btn1 = "btn_134.png", btn2 = "btn_134_s.png", callback = handler(self, self.callbackDelUser)})
	end
	--g_scene:add_layer(ZORDER_LAYER_MORE, layer_more:create('username', list, pos, size, self.callback_user, self.callback_del_user));
	local layer = require("app.layer.pop.LayerPick"):create(nlist, cb)
	Scene:addLayer(Touch.ZORDER_LAYER_PICK, layer, true)
end

function SceneLogin:callbackUser(index)
	local str_list = Util.loadRms('user_list', 'string')
	local list = Util.splitString(str_list)
	local username = list[index]
	if nil == username or '' == username then
		return
	end
	local password = Util.loadRms(username, 'string')
	self._username:setText(username)
	if nil == password or '' == password then
		password = ''
	else
		self._toggle_info:setSelectedIndex(1)
	end
	self._password:setText(password)
end

function SceneLogin:callbackDelUser(index)
	local str_list = Util.loadRms('user_list', 'string')
	local list = Util.splitString(str_list)
	local username = list[index]
	table.remove(list, index)
	local n_str = ''
	for i = 1, #list do
		n_str = list[i] .. ' ' .. n_str
	end
	Util.saveRms('user_list', n_str, 'string')
	Util.removeRms('username')
	if 0 == #list then
		self._username:setText('')
		self._password:setText('')
		self._toggle_info:setSelectedIndex(1)
	end
	if self.username:getText() == username then
		self:callbackUser(1)
	end
end

function SceneLogin:cbServer()
	Audio.playTap1()
	self._server_list = Net:loadServer()
	local list = self._server_list or {}
	local nlist = {}
	for i = 1, #list do
		local info = list[i]
		local title = string.format("%s [ %s ]", info.name, info.state)
		table.insert(nlist, { tag = i, title = title })
	end
	local cb = handler(self, self.changeServer)
	--g_scene:add_layer(ZORDER_LAYER_CSERVER, layer_cserver:create(list, cb));
	local layer = require("app.layer.pop.LayerPick"):create(nlist, cb)
	Scene:addLayer(Touch.ZORDER_LAYER_PICK, layer, true)
end

function SceneLogin:changeServer(index)
	local list = self._server_list or {}
	local info = list[index]
	if nil == info then
		return
	end
--		local item = self._btn_cserver
--		if nil == item then
--			return
--		end
	local label = self._t_server
	if nil == label then
		return
	end
	local ip = info.ip
	local ipstr = Net:getServerName(list, ip)
	--if nil ~= ipstr then return end
	label:setString(ipstr)
--		GUI.addTextToSprite(item, ipstr, 30, GUI.c_white)
	if true == Scene:isOnline() then
		Scene:closeConnect()
	end
	Info.IP_ADDR = ip
	self._is_changed = true
	self:checkIP()
end

function SceneLogin:callbackSaveInfo(tag, sender)
	Audio.playTap2()
	--print('DEBUG callback_save_info');
	-- self._toggle_info:getSelectedIndex()  0 : off     1 : on
	--print('selected item: tag: %d, index:%d', tag, tolua.cast(sender, "cc.MenuItemToggle"):getSelectedIndex());
end

function SceneLogin:saveInfo()
	Audio.playTap3()
	local username = g_euser.username;
	--local username = self.username:getText();
	local u = util.load_rms('username', 'string');
	if nil ~= u and '' ~= u and u ~= username then
		-- clean chat msg
		g_chat_list = {
			[C_ALL] = {},
			[C_WORLD] = {},
			[C_ROOM] = {},
			[C_GUILD] = {},
			[C_PRIVATE] = {},
			[C_LOG] = {},
		};
	end
	if is_ver(VER_ANYSDK) or is_ver(VER_LJSDK) or is_ver(VER_UCSDK) then
		util.save_rms('username', username, 'string');
		local password = g_euser.password;
		util.save_rms('password', password, 'string');
	else
		local toggle_index = self.toggle_info:getSelectedIndex();
		--print('selected item: index:%d', toggle_index);
		util.save_rms('username', username, 'string');
		local password = self.password:getText();
		--print('DBEUG username, password: ', username, password);
		if 1 == toggle_index then
			util.save_rms('password', password, 'string');
		end
	end
	-- TODO need optimize
	local str_list = util.load_rms('user_list', 'string');
	--print(' ----- str_list ', str_list);
	local list = split_string(str_list);
	if 0 == #list then
		str_list = username .. ' ';
	else
		local ishas = false;
		for i = 1, #list do
			if username == list[i] then
				ishas = true;
			end
		end
		if false == ishas then
			str_list = username .. ' ' .. str_list;
		end
	end
	util.save_rms('user_list', str_list, 'string');
	if 1 == toggle_index then
		util.save_rms(username, password, 'string');
	end
end

--[[
function SceneLogin:restart()
	layer_main.delete();
	util.save_rms('ip_addr', IP_ADDR, 'string');
	g_scene:main();
	--sanbox_test(10); -- not work
end
--]]

return SceneLogin

