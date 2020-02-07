local Util = require("app.base.Util")
local Net = require("app.base.Net")
local Info = require("app.base.Info")

local Version = class("Version")

-- see in v_update_res and game.lua check_ip
local ALWAYS_UPDATE = true

local SKIP_UPDATE = false
local RES_DEBUG = true -- use res(include lua) in res/temp

function Version:ctor(...)
	self._btnRetry = nil
	self._btnNext = nil
	self._btnDelRes = nil
	self._progressBar = nil
	self._tip = nil
	self._am = nil
	self._serverList = nil
end

function Version:printSearchPath()
	local utils = cc.FileUtils:getInstance()
	local l = utils:getSearchPaths()
	for i = 1, #l do
		print('path:', i, l[i])
	end
end

function Version:getSavePath()
	return Util.getSavePath()
end

function Version:setTip(tip, no_enter)
	if nil ~= self._tip then
		local t = self._tip:getString()
		if true ~= no_enter then
			t = t .. '\n'
		end
		self._tip:setString(t .. tip)
		--self._tip:setString(tip)
	end
end

function Version:updateByPath(ip_res, ip_version, callback)
	local save_path = self:getSavePath()
	--Util.log('save_path: ', save_path);

	local isSkipCheckVersion = string.len(ip_version or "") == 0

	local item = self._btnRetry
	local bar = self._progressBar
	local progress = bar:getChildByTag(111)
	local amanager = nil

	local function on_success(flag)
		Util.log("success")
		amanager:removeFromParent(true)
		callback(flag)
	end

	local function on_error(error_code)
		Util.err("error_code: ", error_code)
		if error_code == cc.ASSETSMANAGER_CREATE_FILE then
			Util.err("fail create file")
			self:setTip(string.format("创建文件失败"))
			item:setVisible(true)
		elseif error_code == cc.ASSETSMANAGER_NETWORK then
			Util.err("no network")
			if true == isSkipCheckVersion then
				on_success(error_code) -- set a flag true means download res is done
			else
				self:setTip(string.format("网络异常"))
				item:setVisible(true)
			end
		elseif error_code == cc.ASSETSMANAGER_NO_NEW_VERSION then
			Util.log("no new version")
			on_success(error_code) -- set a flag true means download res is done
		elseif error_code == cc.ASSETSMANAGER_UNCOMPRESS then
			Util.err("fail uncompress")
			self:setTip(string.format("解压失败"))
			item:setVisible(true)
		end
	end

	local function on_progress(percent)
		if nil == percent then
			return
		end
		Util.log("percent[%f]", percent)
		progress:setPercentage(percent)
		local x = progress:getPositionX()
		local s1 = progress:getContentSize()
		--local s2 = tap:getContentSize()
		--tap:setPositionX(x - s1.width/2 + s1.width * percent / 100 - s2.width/2)
	end

	--KUtils:deleteDownloadDir(save_path)
	amanager = cc.AssetsManager:new(ip_res, ip_version, save_path)
	if true == ALWAYS_UPDATE then
		--print('version-------: ', amanager:getVersion())
		amanager:deleteVersion()
	end
	self._am:addChild(amanager)
	--amanager = self._am
	--amanager:setPackageUrl(ip_res)
	--amanager:setVersionFileUrl(ip_version)
	--amanager:setStoragePath(save_path)
	--amanager = cc.AssetsManager:new(ip_res, ip_version, save_path); --is autorelease
	--amanager = cc.AssetsManager:create(ip_res, ip_version, save_path, on_error, on_progress, on_success)
	--if true == GAMELUA_DEBUG then
		--amanager:deleteVersion()
	--end
	local user = cc.UserDefault:getInstance()
	local mark = user:getStringForKey('re_update_lua')
	if nil ~= mark and 'yes' == mark then
		amanager:deleteVersion()
	end
	--print('version-------: ', amanager:getVersion())
	--amanager:retain()
	amanager:setDelegate(on_error, cc.ASSETSMANAGER_PROTOCOL_ERROR)
	amanager:setDelegate(on_progress, cc.ASSETSMANAGER_PROTOCOL_PROGRESS)
	amanager:setDelegate(on_success, cc.ASSETSMANAGER_PROTOCOL_SUCCESS)
	amanager:setConnectionTimeout(5)
	--amanager:deleteVersion()

	--[[
	local ver = t_version .. ": " .. amanager:getVersion()
	local label = cc.Label:createWithSystemFont(ver, "Arial", 25)
	label:setAnchorPoint(1, 0)
	label:setPosition(vsize.width, 0)
	layer:addChild(label)
	label_version = label
	]]--

	amanager:checkUpdate()
end

function Version:updateSlist()
	self:setTip(string.format("获取服务器列表..."))
	local flag = 0 -- 0 official, 1 test
	if true == RES_DEBUG then
		flag = 1
	end
	local utils = cc.FileUtils:getInstance()
	local dic = utils:getValueMapFromFile("game_config.plist")
	local ip = dic["IP"]
	local ip_version = string.format("http://%s:8010/evil/version.slist", ip)
	local ip_res = string.format("http://%s:8010/evil/patch.slist?version=%d&flag=%d", ip, Util.CLIENT_VERSION, flag)
	Util.log("download slist version[%s] file[%s]", ip_version, ip_res)
	self:updateByPath(ip_res, ip_version, function(...)
		self:cbSlist(...)
	end)
end

function Version:cbSlist()
	local save_path = self:getSavePath()
	local path = string.format("%sslist", save_path)
	--print ('path: ', path)
	local utils = cc.FileUtils:getInstance()
	--utils:addSearchPath(path)
	local is_has = utils:isFileExist('slist.txt')
	--print('---- is_has slist.txt: ', is_has)
	if true ~= is_has then
		self:setTip(string.format("失败"), true)
		self._btnRetry:setVisible(true)
		return
	end
	local is_test = false
	local path = save_path
	path = path .. 'slist/slist.txt'
	local list = {}
	local file = io.open(path, "r")
	if nil ~= file then
		local data = file:read("*all")
		--print('data: ', data)
		local lines = Util.csplit(data, "[\n\r]")
		for i = 1, #lines do
			--print('line, i: ', i, lines[i]);
			local l = Util.csplit(lines[i], ",")
			-- flag > 0 normal server, == 0 debug server
			local ld = { sid = l[1], ip = l[2], flag = l[3], name = l[4], 
			state = l[5] };
			if true ~= RES_DEBUG and '99' == ld.flag then
				is_test = true
			end
			table.insert(list, ld)
		end   
		io.close(file)
	end 
	if 0 == #list then
		self._btnRetry:setVisible(true)
	end
	local index = 1
	local user = cc.UserDefault:getInstance()
	local mark = user:getStringForKey('ip_addr')
	--print ('mark: ', mark)
	if true == is_test then
		user:setStringForKey('is_test_ip', 'yes')
		mark = nil
	else
		local f = user:getStringForKey('is_test_ip')
		if 'yes' == f then
			user:setStringForKey('is_test_ip', 'no')
			mark = nil
		end
	end
	if nil ~= mark or '' ~= mark then
		for i = 1, #list do
			local info = list[i]
			if mark == info.ip then
				index = i
				break
			end
		end
	end
	mark = list[index].ip
	Net:setServerList(list)
	Info.IP_ADDR = mark
	--http://host:8080/s/patch.core?game_ver=1025&logic_ver=1029
	--version_update_logic(Info.IP_ADDR)
	--print('Info.IP_ADDR: ', Info.IP_ADDR)
	self:setTip(string.format("成功"), true)
	self:updateCore()
end

function Version:updateCore()
	self:setTip(string.format("更新逻辑..."))
	local ip = Info.IP_ADDR
	local user = cc.UserDefault:getInstance()
	local logic_ver = user:getIntegerForKey(Util.KEY_LOGIC_VER)
	local game_ver = user:getIntegerForKey(Util.KEY_GAME_VER)
	--http://host:8080/s/patch.core?game_ver=1025&logic_ver=1029
	local ip_version = string.format("http://%s:8010/evil/version.core", ip)
	local ip_res = string.format("http://%s:8010/evil/patch.core?game_ver=%d&logic_ver=%d", ip, game_ver, logic_ver)
	Util.log("download core version[%s] file[%s]", ip_version, ip_res)
	self:updateByPath(ip_res, ip_version, function(...)
		self:cbCore(...)
	end)
end

function Version:cbCore(flag)
	--print('v_update_core done');
	--[[
	if cc.ASSETSMANAGER_NO_NEW_VERSION == flag then
		self:setTip(string.format("找不到逻辑文件"), true)
		self._btnRetry:setVisible(true)
		return;
	end
	--]]
	self:setTip(string.format("成功"), true)
	--[[
	local utils = cc.FileUtils:getInstance();
	local path = utils:getWritablePath() .. 'g/';
	local ret = KUtils:createDirByPath(path);
	if 0 ~= ret then
		print('BUG create g/ dir fail');
		set_version_tip(string.format("创建文件夹g 失败"));
		version_btn_retry:setVisible(true);
		return;
	end
	utils:addSearchPath(path);
	]]--

	local utils = cc.FileUtils:getInstance()
	--local core_list = {'logic.lua', 'lang_zh.lua', 'game.lua', 'lang_local.lua'};
	local core_list = {'logic.evil', 'lang_zh.lua', 'game.evil', 'lang_local.lua'}
	local tip = ''
	for i=1, #core_list do
		local name = core_list[i]
		if false == utils:isFileExist(name) then
			tip = string.format("%s[%s]", tip, name)
		end
	end
	--[[
	local utils = cc.FileUtils:getInstance();
	local b_logic = utils:isFileExist("logic.lua");
	local b_lang = utils:isFileExist("lang_zh.lua");
	local b_game = utils:isFileExist("game.lua");
	local b_local = utils:isFileExist("lang_local.lua");
	--local b_game = utils:isFileExist("game.evil");
	print('b_logic: ', b_logic);
	print('b_lang: ', b_lang);
	print('b_game: ', b_game);
	print('b_local: ', b_local);
	]]--
	--if true ~= b_logic or true ~= b_lang or true ~= b_game or true ~= b_local then
	if 0 < string.len(tip) then
		self:setTip(string.format("缺少逻辑文件%s", tip))
		self._btnRetry:setVisible(true)
		return
	end

	self:updateRes()
end

function Version:updateRes()
	local ip = Info.IP_ADDR
	local user = cc.UserDefault:getInstance()
	local mark = user:getIntegerForKey(Util.KEY_PATCH_INDEX)
	if 0 == mark then
		mark = Util.CLIENT_PATCH
		user:setIntegerForKey(Util.KEY_PATCH_INDEX, tonumber(mark))
	end
	mark = mark + 1

	local ip_res = string.format("http://%s:8010/evil/res/patch/p%d.ep", ip, mark)
	--print('patch ip_res: ', ip_res)
	Util.log("download patch file[%s]", ip_res)
	self:setTip(string.format("更新资源[%d]...", mark))
	self:updateByPath(ip_res, "", function(...)
		self:cbRes(...)
	end)
end

function Version:cbRes(flag)
	if cc.ASSETSMANAGER_NETWORK == flag then
		self:setTip(string.format("更新资源 完毕"))
		if true == ALWAYS_UPDATE then
			local user = cc.UserDefault:getInstance()
			user:setIntegerForKey(Util.KEY_PATCH_INDEX, tonumber(Util.CLIENT_PATCH))
		end
		self:updateDone()
		return
	end
	local user = cc.UserDefault:getInstance()
	local mark = user:getIntegerForKey(Util.KEY_PATCH_INDEX)
	mark = mark + 1
	user:setIntegerForKey(Util.KEY_PATCH_INDEX, mark)
	self:setTip(string.format("更新资源[%d] 成功", mark))
	self:updateRes()
end

function Version:processData()
	-- TODO: handle error case
	local platform = cc.Application:getInstance():getTargetPlatform()
	if platform == cc.PLATFORM_OS_IPHONE or platform == cc.PLATFORM_OS_IPAD or platform == cc.PLATFORM_OS_MAC then
		local files = {}
		local path = KUtils:getResourcePath() .. '/patch/'
		local list = KUtils:dfsFolder(path, 0)
		print('path, #list:', path, #list)
		for i = 1, #list do
			local fname = list[i]
			local n = string.find(fname, ".ep")
			if n+2 == string.len(fname) then
				local p = path .. fname
				table.insert(files, { path = p, fname = fname })
			end
		end
		self:unzipEp(files)
	elseif platform == cc.PLATFORM_OS_ANDROID then
		local user = cc.UserDefault:getInstance()
		local mark = user:getIntegerForKey(Util.KEY_COPY_ASSETS_INDEX)
		if 1 == mark then
			self:cbAndroidEp()
			return
		end
		local path = cc.FileUtils:getInstance():getWritablePath() .. 'a_local_ep'
		local ret = KUtils:createDirByPath(path)
		if 0 ~= ret then
			print('BUG create a_local_ep dir fail')
		end
		local args = { 
			path, handler(self, self.cbAndroidEp),
		}    
		local sigs = "(Ljava/lang/String;I)V"
		local luaj = require "luaj"
		local class_name = "org/cocos2dx/lua/AppActivity"
		local ok, ret = luaj.callStaticMethod(class_name, "copyRes", args, sigs)
		--print('--- copy_files_to_writable_path, ok, ret: ', ok, ret)
		--if ok then
		--end
	else -- elseif platform == cc.PLATFORM_OS_WINDOWS then
		local files = {}
		-- self:printSearchPath()
		local utils = cc.FileUtils:getInstance()
		local searchPath = utils:getSearchPaths()
		local path = searchPath[1] .. 'res/patch/'
		local list = KUtils:dfsFolder(path, 0)

		for i = 1, #list do
			local fname = list[i]
			local n = string.find(fname, ".ep")
			if n+2 == string.len(fname) then
				local p = path .. fname
				table.insert(files, { path = p, fname = fname })
			end
		end
		self:unzipEp(files)
	end
end

function Version:unzipEp(files)
	local utils = cc.FileUtils:getInstance()
	local user = cc.UserDefault:getInstance()
	local mark = user:getIntegerForKey(Util.KEY_PATCH_INDEX)
	--print('ep num mark: ', mark)
	--local tip = 'unzip:\n';
	local dir_path = Util.getSavePath()
	for i = 1, #files do
		local info = files[i]
		local src_path = info.path
		local fname = info.fname -- e.g. p1.ep
		local index = tonumber(string.sub(fname, 2, string.len(fname)-3)) or 0
		if index > mark then
			local dst_path = dir_path
			set_version_tip(string.format("unpack[%s]...", fname))
			local is_done = KUtils:unzipPatch(src_path, dst_path)
			if true == is_done then
				print('unpack ep done : ', dst_path, index, fname)
				user:setIntegerForKey(Util.KEY_PATCH_INDEX, index)
				--dst_path = dst_path .. string.sub(fname, 1, string.len(fname)-3)
				--utils:addSearchPath(dst_path)
				self:setTip(string.format("unpack[%s] done", fname))
				--tip = string.format("%sfname[%s][just done]\n", tip, fname)
			else
				print('unpack ep fail : ', src_path)
				self:setTip(string.format("unpack[%s] fail", fname))
			end
		else
			--local dst_path = dir_path;
			--dst_path = dst_path .. string.sub(fname, 1, string.len(fname)-3)
			--utils:addSearchPath(dst_path)
			--tip = string.format("%sfname[%s][already done]\n", tip, fname)
		end
	end
	print('unzip done!!!!')
	self._progressBar:setVisible(true)
	self:updateSlist()
end

function Version:cbAndroidEp()
	-- Android:
	-- TODO: ep in asset has copy to writable path, do unzip here, 
	-- 1. maybe should delete the copy file after unzip
	-- 2. set mark to remember has copy the ep or not, maybe do some better way
	local user = cc.UserDefault:getInstance()
	user:setIntegerForKey(Util.KEY_COPY_ASSETS_INDEX, 1)
	local files = {}
	local path = Util.getSavePath .. 'a_local_ep/'
	local ret = KUtils:createDirByPath(path)
	if 0 ~= ret then
		print('BUG cb_android create a_local_ep dir fail')
	end
	local list = KUtils:dfsFolder(path, 0)
	for i = 1, #list do
		local fname = list[i]
		--print('fname: ', fname)
		local n = string.find(fname, ".ep")
		if n+2 == string.len(fname) then
			local p = path .. fname
			table.insert(files, { path = p, fname = fname })
		end
	end
	self:unzipEp(files)
end

function Version:updateDone()
	self._btnRetry:setVisible(false)
	--[[
	version_btn_next:setVisible(true)
	version_btn_del_res:setVisible(true)
	]]--
	self:mainStartGame()
end

function Version:run()
	if true == Util.DEBUG_MODE then
		Util.SHOW_ALL = true
	end

	local platform = cc.Application:getInstance():getTargetPlatform()
	cc.FileUtils:getInstance():addSearchPath("src")
	cc.FileUtils:getInstance():addSearchPath("res")
	if platform == cc.PLATFORM_OS_IPHONE or platform == cc.PLATFORM_OS_IPAD or platform == cc.PLATFORM_OS_MAC then
		cc.FileUtils:getInstance():addSearchPath("startup")
	elseif platform == cc.PLATFORM_OS_ANDROID then
		cc.FileUtils:getInstance():addSearchPath("res/startup")
	else -- windows
		cc.FileUtils:getInstance():addSearchPath("res/startup")
	end
	local res_path = self:getSavePath()
	KUtils:createDirByPath(res_path)
	cc.FileUtils:getInstance():addSearchPath(res_path)

	local dic = cc.FileUtils:getInstance():getValueMapFromFile("game_config.plist")
	Info.CPID = dic["CPID"]
	Info.CHANNEL_VER = dic["CHANNEL_VER"]

	--Util.log("pos[%f][%f]size[%f][%f]",origin.x,origin.y,vsize.width,vsize.height)

	print('--jit.version: ', jit.version)

	--local ffi = require 'ffi'
	--print('------ luajit : ', jit.version)
	--table.foreach(ffi, print)

	self:printSearchPath()

	local langType = Util.getLanguage()
	local tRetry, tVersion
	if langType == cc.LANGUAGE_CHINESE then -- chinese
		tRetry = '重试'
		tVersion = '资源版本'
	else
		tRetry = 'reload'
		tVersion = 'version'
	end

	local director = cc.Director:getInstance()
	local vsize = director:getVisibleSize()

	local layer = cc.Layer:create()
	local sprite = cc.Sprite:create("bg_200.png")
	sprite:setAnchorPoint(cc.p(0.5, 0.5))
	sprite:setPosition(vsize.width/2, vsize.height/2)
	layer:addChild(sprite)

	sprite = cc.Sprite:create("logo_1.png")
	sprite:setAnchorPoint(0.5, 1)
	sprite:setPosition(vsize.width/2, vsize.height/2+328)
	layer:addChild(sprite)

	local pos = cc.p(vsize.width/2, 200)
	local bar = cc.Node:create()
	bar:setAnchorPoint(0.5, 0)
	bar:setPosition(pos)
	layer:addChild(bar)

	sprite = cc.Sprite:create("bg_207.png")
	sprite:setAnchorPoint(0.5, 0.5)
	sprite:setPosition(cc.p(0, 0))
	bar:addChild(sprite)

	sprite = cc.Sprite:create("bg_208.png")
	local progress = cc.ProgressTimer:create(sprite)
	progress:setAnchorPoint(0.5, 0.5)
	progress:setPosition(cc.p(0, 0))
	progress:setType(cc.PROGRESS_TIMER_TYPE_BAR)
	progress:setMidpoint(cc.p(0, 1))
	progress:setBarChangeRate(cc.p(1, 0))
	progress:setPercentage(0)
	progress:setTag(111)
	bar:addChild(progress)

	sprite = cc.Sprite:create("bg_209.png")
	sprite:setAnchorPoint(0.5, 0.5)
	sprite:setPosition(cc.p(0, 0))
	bar:addChild(sprite)

	self._progressBar = bar

	sprite = cc.Node:create()
	layer:addChild(sprite)
	self._am = sprite

	sprite = cc.Label:createWithSystemFont('开启...', "Arial", 25, cc.size(vsize.width, vsize.height/2), cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM)
	sprite:setColor(cc.c3b(0, 0, 0))
	sprite:setAnchorPoint(0.5, 0)
	sprite:setPosition(cc.p(vsize.width/2, 300))
	layer:addChild(sprite)
	self._tip = sprite

	local menu = cc.Menu:create()
	menu:setPosition(0, 0)
	layer:addChild(menu)

	local item, l
	local function cb_retry(...)
		local args = {...}
		local item = args[2]
		self._tip:setString('重新更新')
		item:setVisible(false)
		self:updateSlist(Info.IP_ADDR)
	end
	item = cc.MenuItemImage:create("btn_99.png", "btn_99_s.png")
	item:setAnchorPoint(0.5, 0)
	item:setPosition(vsize.width/2, 80)
	item:registerScriptTapHandler(cb_retry)
	l = cc.Label:createWithSystemFont(tRetry, "Arial", 25)
	l:setAnchorPoint(0.5, 0.5)
	l:setPosition(item:getContentSize().width/2, item:getContentSize().height/2)
	item:addChild(l)
	item:setVisible(false)
	self._btnRetry = item
	menu:addChild(item)

	local folders = { 'slist', 'core', 'res' }
	local wpath = self:getSavePath()
	for i = 1, #folders do
		local f = folders[i]
		local p = wpath .. f
		local ret = KUtils:createDirByPath(p)
		if 0 ~= ret then
			self:setTip(string.format("创建文件夹%s 失败", f))
			self._btnRetry:setVisible(true)
			return
		end
		cc.FileUtils:getInstance():addSearchPath(p, true)
	end

	if true == RES_DEBUG then
		local platform = cc.Application:getInstance():getTargetPlatform()
		if platform == cc.PLATFORM_OS_IPHONE or platform == cc.PLATFORM_OS_IPAD or platform == cc.PLATFORM_OS_MAC then
			cc.FileUtils:getInstance():addSearchPath("temp", true)
		elseif platform == cc.PLATFORM_OS_ANDROID then
			cc.FileUtils:getInstance():addSearchPath("res/temp", true)
		else -- windows
			cc.FileUtils:getInstance():addSearchPath("res/temp", true)
		end
		Util.DEBUG_MODE = true
	end

	--self:processData()
	if true == SKIP_UPDATE then
		local utils = cc.FileUtils:getInstance()
		local dic = utils:getValueMapFromFile("game_config.plist")
		local ip = dic["IP"]
		local ld = { sid = '1', ip = ip, flag = '1', name = '本机', state = '1' }
		local list = { ld }
		self._serverList = list
		Info.IP_ADDR = ip
		local function cb_start()
			layer:unscheduleUpdate()
			self:mainStartGame()
		end
		layer:scheduleUpdateWithPriorityLua(cb_start, 1)
	else
		self:updateSlist()
	end

	local tap_count = 10
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:setSwallowTouches(true)
	listener:registerScriptHandler(
		function(touch, event)
			return true
		end,  
		cc.Handler.EVENT_TOUCH_BEGAN
	);    
	listener:registerScriptHandler(
		function(touch, event)
			if true == Util.DEBUG_MODE then
				return
			end
			local location = touch:getLocation()
			if location.x > vsize.width-100 and location.y > vsize.height-100 then
				tap_count = tap_count - 1
			end
			if tap_count < 0 then
				self:setTip(string.format("====测试模式===="))
				Util.DEBUG_MODE = true
			end
		end,  
		cc.Handler.EVENT_TOUCH_ENDED
	)
	local eventDispatcher = layer:getEventDispatcher()
	--print('lis layer: ', listener, layer, tolua.type(eventDispatcher));
	--eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer);
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

	local scene = cc.Scene:create();
	scene:addChild(layer);

	if director:getRunningScene() then
		director:replaceScene(scene);
	else
		director:runWithScene(scene);
	end
end

function Version:mainStartGame()
	--self:printSearchPath();
	local user = cc.UserDefault:getInstance();
	user:setIntegerForKey(Util.KEY_LOGIC_VER, tonumber(Util.LOGIC_VERSION));
	user:setIntegerForKey(Util.KEY_GAME_VER, tonumber(Util.GAME_VERSION));
    require("app.scene.SceneLogin").showScene()
end

return Version
