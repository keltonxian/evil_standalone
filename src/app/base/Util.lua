
local Util = class("Util")

Util.DEBUG_MODE         = false
Util.SHOW_ALL           = false

Util.LOCAL_TEST         = false

Util.IS_MUTE            = true

Util.SHOW_VERSION = 00001
Util.KEY_COPY_ASSETS_INDEX = 'copy_assets_index'
Util.KEY_LOGIC_VER = 'core_logic_ver'
Util.KEY_GAME_VER = 'core_game_ver'
Util.GAME_VERSION = 00001
Util.LOGIC_VERSION = 00001
Util.KEY_PATCH_INDEX = 'unzip_ep_index'

Util.CLIENT_VERSION = 00001
Util.CLIENT_PATCH_CONSTANT = 1 -- for game.lua layer_debug delete_res
Util.CLIENT_PATCH = Util.CLIENT_PATCH_CONSTANT

local g_lang = nil
local g_sensitive_list = nil

Util.F_IMAGE      = 'image/'
Util.F_PIC        = 'pic/'
Util.F_FONT       = 'font/'
Util.F_PARTICLE   = 'particle/'
Util.F_BGM        = 'bgm/'
Util.F_SOUND      = 'sound/'
Util.F_DOCX       = 'docx/'
Util.F_ANIM       = 'anim/'
Util.F_LANG       = nil
Util.F_RES        = '/' -- see util.lua , will insert search path

Util.FNT_CARD    = 'font_card.fnt'
Util.FNT_CARD_2  = 'font_card2.fnt'
Util.FNT_TIME    = 'font_time.fnt'
Util.FNT_1       = 'font_num_1.fnt'
Util.FT_1        = 'font_1.fnt' -- player status(gold, crystal, energy)
Util.FT_2        = 'font_2.fnt' -- vip and battle result target num
Util.FT_3        = 'font_3.fnt' -- level
Util.FT_4        = 'font_4.fnt' -- battle round, battle result num
Util.FT_5        = 'font_5.fnt' -- hero power
Util.FT_6        = 'font_6.fnt' -- hero hp
Util.FT_7        = 'font_7.fnt' -- chapter tower num
Util.FT_8        = 'font_8.fnt' -- deck card num
Util.FT_9        = 'font9.fnt'  -- card left_down number change
Util.FT_10       = 'font10.fnt' -- card right_down number change
Util.FT_11       = 'font11.fnt' -- battle res num change
Util.FT_12       = 'font12.fnt' -- big version of FT_5

function Util.log(...)
	printLog("DBEUG", ...)
end

function Util.err(...)
	printLog("ERROR", ...)
end

-- delim e.g " " or "[ ]" or "[%.]" or "[%. ]"
function Util.csplit(str, delim)
	--print('DEBUG csplit str, delim: ', str, delim);
	local result = {};
	if nil == str then
		return result;
	end 
	local count = 200; -- max 200 token
	local token; 

	repeat 
		local s_pos, e_pos = string.find(str, delim);
			if s_pos==nil or e_pos == nil then
			break; 
		end 
		-- print('s_pos = ', s_pos, ' e_pos = ', e_pos);
		token = string.sub(str, 1, s_pos-1);
		if string.len(token) > 0 then
			result[ #result + 1] = token;
		end 
		str = string.sub(str, e_pos+1); -- missing len means up to full len
		-- print('Result i : ', result[#result], '  str=', str);
		count = count - 1;
	until count <= 0;

	if string.len(str) > 0 then
		result[ #result + 1] = str ;
	end

	return result;
end

function Util.getLanguage()
	return cc.LANGUAGE_CHINESE, 'chinese'
	--[[
	local application = cc.Application:getInstance()
	local language = application:getCurrentLanguage()
	local l_str
	if cc.LANGUAGE_ENGLISH == language then
		l_str = 'English'
	else
		language = cc.LANGUAGE_CHINESE
		l_str = 'chinese'
	end
	Util.log('util system language,type: ', l_str, language)
	return language, l_str
	--]]
end

function Util.initLang()
	local lang_type = Util.getLanguage()
	if lang_type == cc.LANGUAGE_CHINESE then -- chinese
		g_lang = require("app.localize.langCN")
		Util.F_LANG = 'image_cn/'
	else -- 2 english
		g_lang = require("app.localize.langEN")
		Util.F_LANG = 'image_en/'
	end
end

function Util.lText(key)
	if nil == g_lang or nil == key then
		return ''
	end
	local text = g_lang[key] or ''
	return text
end

function Util.saveRms(key, value, data_type) -- {
	local user = cc.UserDefault:getInstance()
	if 'bool' == data_type then
		-- nil == false
		--value = value or false
		user:setBoolForKey(key, value)
	elseif 'double' == data_type then
		value = value or 0
		user:setDoubleForKey(key, value)
	elseif 'float' == data_type then
		value = value or 0
		user:setFloatForKey(key, value)
	elseif 'integer' == data_type then
		value = value or 0
		user:setIntegerForKey(key, value)
	--elseif 'string' == data_type then
	else
		value = value or '???'
		user:setStringForKey(key, value)
	end
	local flag = user:flush()
	if false == flag then
		Util.log('util save rms false key:', key)
	end
end -- Util.saveRms }

function Util.loadRms(key, data_type) -- {
	local user = cc.UserDefault:getInstance()
	local value
	if 'bool' == data_type then
		value = user:getBoolForKey(key)
	elseif 'double' == data_type then
		value = user:getDoubleForKey(key)
	elseif 'float' == data_type then
		value = user:getFloatForKey(key)
	elseif 'integer' == data_type then
		value = user:getIntegerForKey(key)
	--elseif 'string' == data_type then
	else
		value = user:getStringForKey(key)
	end
	return value
end -- Util.loadRms }

function Util.removeRms(key) -- {
	local user = cc.UserDefault:getInstance()
	user:setStringForKey(key, nil)
	local flag = user:flush()
	if false == flag then
		Util.log('util remove rms false key:', key)
	end
end -- Util.loadRms }

function Util.getSavePath()
	local path = cc.FileUtils:getInstance():getWritablePath() .. "evil/"
	--local path = cc.FileUtils:getInstance():getWritablePath()
	return path
end

function Util.getFullPath(foldername, filename, default)
	foldername = ''
	-- 1. check the download folder
	local file_utils = cc.FileUtils:getInstance()
	--[[
	local is_has = file_utils:isFileExist(filename)
	if true == is_has then
		return filename
	end
	]]--
	local write_path = Util.getSavePath()
	local fname = foldername .. filename
	local fullpath = write_path .. 'res/' .. fname
	local is_exist = file_utils:isFileExist(fullpath)
	if true ~= is_exist then
		fullpath = write_path .. 'res/' .. filename
		is_exist = file_utils:isFileExist(fullpath)
	end
	--print('fullpath, is_exist: ', fullpath, is_exist)
	if true == is_exist then
		return fullpath, true
	end
	-- 2. check local folder
	local unknown = 'image/unknown.png'
	if nil ~= default then
		unknown = foldername .. default
	end
	local application = cc.Application:getInstance()
	local platform = application:getTargetPlatform()
	if platform == cc.PLATFORM_OS_ANDROID then
		fullpath = fname
		is_exist = file_utils:isFileExist(fullpath)
		if false == is_exist and foldername == F_IMAGE then
			fullpath = F_LANG .. filename
			is_exist = file_utils:isFileExist(fullpath)
		end
		if false == is_exist then
			fullpath = unknown
		end
	else
		fullpath = file_utils:fullPathForFilename(fname)
		is_exist = file_utils:isFileExist(fullpath)
		if false == is_exist and foldername == F_IMAGE then
			fname = F_LANG .. filename
			fullpath = file_utils:fullPathForFilename(fname)
			is_exist = file_utils:isFileExist(fullpath)
		end
		if false == is_exist then
			fullpath = file_utils:fullPathForFilename(unknown)
		end
	end
	--print('fullpath: ', fullpath)
	if false == is_exist then
		Util.log("file not exist: ", foldername, filename)
	end
	return fullpath, is_exist
end

function Util.getPath(filename, default)
	-- 1. check the download folder
	local file_utils = cc.FileUtils:getInstance()
	if true == Util.checkFile(filename) then
		return filename, true
	end
	-- 2. check local folder
	--local unknown = 'image/unknown.png'
	local unknown = default or 'unknown.png'
	if nil ~= default then
		unknown = default
	end
	local is_exist = file_utils:isFileExist(unknown)
	--print('fullpath: ', fullpath)
	if false == is_exist then
		print("get_path : file not exist: ", filename)
	end
	return unknown, is_exist
end

function Util.checkFile(filename)
	local file_utils = cc.FileUtils:getInstance()
	local is_exist = file_utils:isFileExist(filename)
	if true == is_exist then
		return true
	end
	Util.log("Util.checkFile [%s] not exist", filename)
	return false
end

function Util.openFile(foldername, filename)
	foldername = ''
	local str = nil
	local flag = Util.checkFile(foldername .. filename)
	if false == flag then
		Util.err("Util.openFile [%s][%s] fail", foldername, filename)
		return str
	end
	local fullpath = Util.getFullPath(foldername, filename)
	local file_utils = cc.FileUtils:getInstance()
	str = file_utils:getStringFromFile(fullpath)
	--[[
	local application = cc.Application:getInstance();
	local platform = application:getTargetPlatform();
	if platform == cc.PLATFORM_OS_ANDROID then
		-- deprecated
		--local cstring = CCString:createWithContentsOfFile(fullpath);
		--str = cstring:getCString();
	else
		local file = io.open(fullpath);
		if nil == file then
			print('BUG open file ios file not exists: ', fullpath);
			return str;
		end
		str = file:read("*all");
		io.close(file);
	end
	]]--
	return str
end

function Util.loadSensitiveData()
	g_sensitive_list = {};
	local str = Util.openFile(Util.F_DOCX, 'sensitive_name.fl')
	local list_line = Util.csplit(str, "[\r\n]", 3000)
	local list = {}
	for i = 1, #list_line do
		local line = list_line[i]
		line = string.gsub(line, "\n", "")
		line = string.gsub(line, "\r", "")
		local column = Util.csplit(line, "+");
		list[#list+1] = column
	end
	g_sensitive_list = list
end

function Util.checkHasSensitiveData(info)
	if nil == info or #info <= 0 then
		return false
	end
	
	local sen_list
	local count = 0
	for i = 1, #g_sensitive_list do
		sen_list = g_sensitive_list[i]
		count = 0
		for j = 1, #sen_list do
			if nil == string.find(info, sen_list[j]) then
				break
			end
--			print('cmp str:', info, sen_list[j])
			count = count + 1
		end
--		print('cmp count:', count, #sen_list)
		if count == #sen_list then
			return true
		end
	end
	return false
end

function Util.replaceSensitiveData(info)
	if nil == info or #info <= 0 then
		return info
	end

	local sen_list
	local pos_list
	local spos, epos
	for i = 1, #g_sensitive_list do
		sen_list = g_sensitive_list[i]
		pos_list = {}
		for j = 1, #sen_list do
			spos, epos = string.find(info, sen_list[j])
			if nil == spos then
				break
			end
			pos_list[#pos_list+1] = { spos = spos, epos = epos }
		end
		if #pos_list == #sen_list then
			for k = 1, #sen_list do
				info = string.gsub(info, sen_list[k], '***')
			end
		end
	end
	return info
end

function Util.freeRam()
	local cache = cc.Director:getInstance():getTextureCache()
	cache:removeUnusedTextures()
	cache = cc.SpriteFrameCache:getInstance()
	cache:removeUnusedSpriteFrames()
end

function Util.getClientVersion()
	local str
	local sver = Util.SHOW_VERSION
	local cver = Util.CLIENT_VERSION
	local kpIndex = Util.KEY_PATCH_INDEX
	if nil ~= sver then
		local c1 = math.floor(sver/10000)
		local c2 = sver%10000
		local cv = c1 .. '.' .. c2
		local c3 = cc.UserDefault:getInstance():getIntegerForKey(kpIndex)
		str = Util.lText("CLIENT_VER") .. ':' .. cv .. '.' .. c3
	else
		local c1 = math.floor(cver/10000)
		local c2 = cver%10000
		local cv = c1 .. '.' .. c2
		local c3 = cc.UserDefault:getInstance():getIntegerForKey(kpIndex)
		str = Util.lText("CLIENT_VER") .. ':' .. cv .. '.' .. Util.GAME_VERSION .. '_' .. UtilLOGIC_VERSION .. '.' .. c3
	end
	--[[
	if is_ver(VER_ANYSDK) or is_ver(VER_ANYSDK_NO_LOGIN) then
		local f = AgentManager:getInstance():getFrameworkVersion() or ''
		if f ~= '' then
			str = f .. '\n' .. str
		end
	end
	]]--
	return str
end

function Util.deleteDownloadResource()
	Util.CLIENT_PATCH = Util.CLIENT_PATCH_CONSTANT
	local user = cc.UserDefault:getInstance()
	user:setIntegerForKey(Util.KEY_PATCH_INDEX, tonumber(Util.CLIENT_PATCH))
	local path = self:getSavePath() .. 'res/'
	local list = KUtils:dfsFolder(path, 0)
	for i = 1, #list do
		local fname = list[i]
		local p = path .. fname
		KUtils:deleteDownloadDir(p)
	end 
end

function Util.clearLoadedInfo(filename)
	if nil == filename then return end
	if package.loaded[filename] then
		package.loaded[filename] = nil
	end
end

function Util.relaunchGame()
	Util.clearLoadedInfo("version")
	--[[
	Util.clearLoadedInfo("game")
	Util.clearLoadedInfo("lang_local")
	Util.clearLoadedInfo("logic")
	Util.clearLoadedInfo("lang_zh")
	--]]
    require("version"):create():run()
end

function Util.splitString(str)
	return Util.csplit(str, ' ')
end

return Util
