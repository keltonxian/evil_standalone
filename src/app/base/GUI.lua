local Util = require("app.base.Util")
local Touch = require("app.base.Touch")

local GUI = class("GUI")

GUI.FULL_WIDTH = nil
GUI.FULL_HEIGHT = nil
GUI.HALF_WIDTH = nil
GUI.HALF_HEIGHT = nil
GUI.ANIM_SCALE_CENTER = nil

-- anchor point
GUI.ANCHOR_NULL        = 99 -- the value is useless, just define for not scale
GUI.ANCHOR_LEFT        = 0
GUI.ANCHOR_RIGHT       = 1
GUI.ANCHOR_UP          = 1
GUI.ANCHOR_DOWN        = 0
GUI.ANCHOR_CENTER      = 0.5

GUI.ANCHOR_LEFT_UP		= cc.p(GUI.ANCHOR_LEFT,   GUI.ANCHOR_UP)
GUI.ANCHOR_LEFT_DOWN	= cc.p(GUI.ANCHOR_LEFT,   GUI.ANCHOR_DOWN)
GUI.ANCHOR_LEFT_CENTER	= cc.p(GUI.ANCHOR_LEFT,   GUI.ANCHOR_CENTER)
GUI.ANCHOR_RIGHT_UP  	= cc.p(GUI.ANCHOR_RIGHT,  GUI.ANCHOR_UP)
GUI.ANCHOR_RIGHT_DOWN	= cc.p(GUI.ANCHOR_RIGHT,  GUI.ANCHOR_DOWN)
GUI.ANCHOR_RIGHT_CENTER	= cc.p(GUI.ANCHOR_RIGHT,  GUI.ANCHOR_CENTER)
GUI.ANCHOR_CENTER_CENTER= cc.p(GUI.ANCHOR_CENTER, GUI.ANCHOR_CENTER)
GUI.ANCHOR_CENTER_UP    = cc.p(GUI.ANCHOR_CENTER, GUI.ANCHOR_UP)
GUI.ANCHOR_CENTER_DOWN  = cc.p(GUI.ANCHOR_CENTER, GUI.ANCHOR_DOWN)

GUI.GUI_CHAPTER    = 1
GUI.GUI_DAILY      = 2
GUI.GUI_DECK       = 3
GUI.GUI_EXCHANGE   = 4
GUI.GUI_HERO       = 5
GUI.GUI_HMISS      = 6
GUI.GUI_LOGIN      = 7
GUI.GUI_MAIL       = 8
GUI.GUI_MAIN       = 9
GUI.GUI_MATCH      = 10
GUI.GUI_MISSION    = 11
GUI.GUI_MYDECK     = 12
GUI.GUI_MYSTERY    = 13
GUI.GUI_NOTICE     = 14
GUI.GUI_PCLG       = 15
GUI.GUI_PICKDECK   = 16
GUI.GUI_PIECE      = 17
GUI.GUI_PLAYERINFO = 18
GUI.GUI_PMYSTERY   = 19
GUI.GUI_RANK       = 20
GUI.GUI_QUICK      = 21
GUI.GUI_RESULT     = 22
GUI.GUI_ROLE       = 23
GUI.GUI_SGDECK     = 24
GUI.GUI_SHOP       = 25
GUI.GUI_STAGE      = 26
GUI.GUI_PAY        = 27
GUI.GUI_VIDEO      = 28
GUI.GUI_GUILD      = 29
GUI.GUI_GUILDUP    = 30
GUI.GUI_MEMBER     = 31
GUI.GUI_LGUILD     = 32
GUI.GUI_APPROVE    = 33
GUI.GUI_BOOK       = 34
GUI.GUI_INVEST     = 35
GUI.GUI_STOCK      = 36
GUI.GUI_RECORD     = 37
GUI.GUI_OPTION     = 38
GUI.GUI_CHAT       = 39
GUI.GUI_BCHAT      = 40
GUI.GUI_LROOM      = 41
GUI.GUI_LWAIT      = 42
GUI.GUI_ROOM       = 43
GUI.GUI_FRIEND     = 44
GUI.GUI_SFRIEND    = 45

--[[
GUI.GUI_PRACTICE   = 4
GUI.GUI_ARENA      = 12
GUI.GUI_GM         = 15
GUI.GUI_WELFARE    = 21
GUI.GUI_LMATCH     = 30
GUI.GUI_SERVICE    = 33
GUI.GUI_GATE       = 34
GUI.GUI_LOTTERY    = 35
GUI.GUI_PAY_AD     = 36
]]--

GUI.c4b_text = cc.c4b(68, 37, 16, 255)
GUI.c4b_white = cc.c4b(255, 255, 255, 255)
GUI.c4b_black = cc.c4b(0, 0, 0, 255)
GUI.c4b_red = cc.c4b(255, 0, 0, 255)
GUI.c4b_gold = cc.c4b(255, 228, 21, 255)
GUI.c4b_crystal = cc.c4b(236, 99, 131, 255)
GUI.c4b_name = cc.c4b(28, 247, 90, 255)
GUI.c4b_info = cc.c4b(175, 188, 177, 255)
GUI.c_white = cc.c3b(255, 255, 255)
GUI.c_gray = cc.c3b(200, 200, 255)
GUI.c_black = cc.c3b(0, 0, 0)
GUI.c_red = cc.c3b(255, 0, 0)
GUI.c_yellow = cc.c3b(255, 255, 0)
GUI.c_name = cc.c3b(28, 247, 90)
GUI.c_gold = cc.c3b(255, 228, 21)
GUI.c_crystal = cc.c3b(236, 99, 131)
GUI.f_default = 'Arial'

GUI.TAG_SPRITE_LABEL     = 100
GUI.TAG_CELL_BG          = 500
GUI.TAG_CELL_LABEL       = 502
GUI.TAG_CELL_CARD_SPRITE = 510
GUI.TAG_LAYER_COLOR      = 520

local gui_list = {}

local gui_info = {
	{ key = GUI.GUI_CHAPTER, file = 'ui_chapter.csv' },
	{ key = GUI.GUI_DAILY, file = 'ui_daily.csv' },
	{ key = GUI.GUI_DECK, file = 'ui_deck.csv' };
	{ key = GUI.GUI_EXCHANGE, file = 'ui_exchange.csv' },
	{ key = GUI.GUI_HERO, file = 'ui_hero.csv' },
	{ key = GUI.GUI_HMISS, file = 'ui_heromiss.csv' },
	{ key = GUI.GUI_LOGIN, file = 'ui_login.csv' };
	{ key = GUI.GUI_MAIL, file = 'ui_mail.csv' },
	{ key = GUI.GUI_MAIN, file = 'ui_main.csv' };
	{ key = GUI.GUI_MATCH, file = 'ui_match.csv' };
	{ key = GUI.GUI_MISSION, file = 'ui_mission.csv' },
	{ key = GUI.GUI_MYDECK, file = 'ui_mydeck.csv' },
	{ key = GUI.GUI_MYSTERY, file = 'ui_mystery.csv' },
	{ key = GUI.GUI_NOTICE, file = 'ui_notice.csv' },
	{ key = GUI.GUI_PCLG, file = 'ui_pclg.csv' },
	{ key = GUI.GUI_PICKDECK, file = 'ui_pickdeck.csv' },
	{ key = GUI.GUI_PIECE, file = 'ui_piece.csv' },
	{ key = GUI.GUI_PLAYERINFO, file = 'ui_playerinfo.csv' };
	{ key = GUI.GUI_PMYSTERY, file = 'ui_pmystery.csv' },
	{ key = GUI.GUI_RANK, file = 'ui_rank.csv' };
	{ key = GUI.GUI_QUICK, file = 'ui_quick.csv' };
	{ key = GUI.GUI_RESULT, file = 'ui_result.csv' },
	{ key = GUI.GUI_ROLE, file = 'ui_role.csv' };
	{ key = GUI.GUI_SGDECK, file = 'ui_sgdeck.csv' },
	{ key = GUI.GUI_SHOP, file = 'ui_shop.csv' };
	{ key = GUI.GUI_STAGE, file = 'ui_stage.csv' },
	{ key = GUI.GUI_PAY, file = 'ui_pay.csv' },
	{ key = GUI.GUI_VIDEO, file = 'ui_video.csv' };
	{ key = GUI.GUI_GUILD, file = 'ui_guild.csv' },
	{ key = GUI.GUI_GUILDUP, file = 'ui_guildup.csv' },
	{ key = GUI.GUI_MEMBER, file = 'ui_member.csv' },
	{ key = GUI.GUI_LGUILD, file = 'ui_lguild.csv' },
	{ key = GUI.GUI_APPROVE, file = 'ui_approve.csv' },
	{ key = GUI.GUI_BOOK, file = 'ui_book.csv' },
	{ key = GUI.GUI_INVEST, file = 'ui_invest.csv' },
	{ key = GUI.GUI_STOCK, file = 'ui_stock.csv' },
	{ key = GUI.GUI_RECORD, file = 'ui_record.csv' },
	{ key = GUI.GUI_OPTION, file = 'ui_option.csv' },
	{ key = GUI.GUI_CHAT, file = 'ui_chat.csv' };
	{ key = GUI.GUI_BCHAT, file = 'ui_bchat.csv' };
	{ key = GUI.GUI_LROOM, file = 'ui_lroom.csv' };
	{ key = GUI.GUI_LWAIT, file = 'ui_lwait.csv' };
	{ key = GUI.GUI_ROOM, file = 'ui_room.csv' },
	{ key = GUI.GUI_FRIEND, file = 'ui_friend.csv' },
	{ key = GUI.GUI_SFRIEND, file = 'ui_sfriend.csv' },

	--[[
	{ key = GUI.GUI_PRACTICE, file = 'ui_practice.csv' };
	{ key = GUI.GUI_GM, file = 'ui_gm.csv' };
	--{ key = GUI.GUI_WELFARE, file = 'ui_welfare.csv' },
	{ key = GUI.GUI_LMATCH, file = 'ui_lmatch.csv' },
	{ key = GUI.GUI_SERVICE, file = 'ui_service.csv' },
	{ key = GUI.GUI_GATE, file = 'ui_gate.csv' },
	{ key = GUI.GUI_LOTTERY, file = 'ui_lottery.csv' },
	{ key = GUI.GUI_PAY_AD, file = 'ui_pay_ad.csv' },
	]]--
}

local SCREEN_SIZE_REF = { width = 640, height = 960 }

local GUI.g_scale = {}
local GUI.g_sprite_cache = {} -- table card
local GUI.g_pic_cache = {} -- grave

function GUI.cleanSpriteCache()
	for c, s in pairs(GUI.g_sprite_cache) do
		-- check the value kind, do check clean only if it is sprite
		-- card.pos == nil means this card will never use again, can remove it
		--if tolua.type(s) == 'cc.Sprite' and nil == c.pos then
		if nil ~= s.removeFromParentAndCleanup and nil == c.pos then
			Util.log('DEBUG refresh_and_remove: ' ..  c.name)
			--TODO always bug here
			s:removeFromParentAndCleanup(true)
			-- TODO
			-- should remove key and value  from table after remove sprite
			GUI.g_sprite_cache[c] = nil
		end
	end
	
	for c, s in pairs(GUI.g_pic_cache) do
		if nil ~= s.removeFromParentAndCleanup and nil == c.pos then
			s:removeFromParentAndCleanup(true);
			GUI.g_pic_cache[c] = nil;
		end
	end
end

function GUI.init()
    local vsize = cc.Director:getInstance():getVisibleSize()	 
	GUI.FULL_WIDTH = vsize.width
	GUI.FULL_HEIGHT = vsize.height
    GUI.HALF_WIDTH = GUI.FULL_WIDTH / 2
    GUI.HALF_HEIGHT = GUI.FULL_HEIGHT / 2
	Util.log("Visible Size width[%d] height[%d]", GUI.FULL_WIDTH, GUI.FULL_HEIGHT)

	GUI.g_scale = {}
	GUI.g_scale.x = GUI.FULL_WIDTH / SCREEN_SIZE_REF.width
	GUI.g_scale.y = GUI.FULL_HEIGHT / SCREEN_SIZE_REF.height

	if GUI.g_scale.x > GUI.g_scale.y then
		GUI.ANIM_SCALE_CENTER = GUI.g_scale.y;
	else
		GUI.ANIM_SCALE_CENTER = GUI.g_scale.x;
	end

	GUI.initListData()
end

function GUI.initListData()
	local list_file = gui_info
	for i = 1, #list_file do
		local info = list_file[i]
		local key = info.key
		local filename = info.file
		local str = Util.openFile(Util.F_DOCX, filename)
		local l = GUI.loadData(key, str)
		local len = string.len(filename)
		l.rname = string.sub(filename, 1, len-4);
		gui_list[key] = l
	end
end

function GUI.loadData(ltype, str)
	local list_line = Util.csplit(str, "[\r\n]")
	table.remove(list_line, 1)
	table.remove(list_line, 1)
	table.remove(list_line, 1)
	local list = {}
	for i = 1, #list_line do
		local line = list_line[i]
		line = string.gsub(line, "\n", "")
--		print('gui line: ', line)
		local colomn = Util.csplit(line, ",")
		if #colomn >= 11 then
			local key = colomn[1]
			-- if is toggle, filename1 is unselected, filename2 is selected
			local filename1 = colomn[2]
			local filename2 = colomn[3]
			local xpsd = tonumber(colomn[4])
			local ypsd = tonumber(colomn[5])
			local width = tonumber(colomn[6])
			local height = tonumber(colomn[7])
			local zorder = tonumber(colomn[8])
			local istoggle = tonumber(colomn[9]) -- 0 false 1 true
			local label1 = colomn[10]
			local label2 = colomn[11]
			local owidth = tonumber(colomn[12]) or 0
			local oheight = tonumber(colomn[13]) or 0
			--local is_9scale = (0==owidth) and false or true
			local r = tonumber(colomn[14]) or 0
			local g = tonumber(colomn[15]) or 0
			local b = tonumber(colomn[16]) or 0
			local sr = tonumber(colomn[17]) or 0
			local sg = tonumber(colomn[18]) or 0
			local sb = tonumber(colomn[19]) or 0
			local x, y
			x, y = GUI.psdXY(xpsd, ypsd, width, height, ltype)
			local data = {}
			data.key = key
			data.filename1 = filename1
			data.filename2 = filename2
			data.x = x
			data.y = y
			data.width = width
			data.height = height
			data.zorder = zorder
			data.istoggle = istoggle
			data.label1 = label1
			data.label2 = label2
			data.owidth = owidth
			data.oheight = oheight
			--data.is_9scale = is_9scale
			data.r = r
			data.g = g
			data.b = b
			data.sr = sr
			data.sg = sg
			data.sb = sb
			list[key] = data
		end
	end
	
	return list
end

function GUI.psdXY(xpsd, ypsd, width, height, ltype)
	local size = SCREEN_SIZE_REF
	local x = xpsd
	local y = size.height - ypsd - height

	return x, y
end

function GUI.wfix(width)
	width = width * GUI.g_scale.x
	return width
end

function GUI.hfix(height)
	height = height * GUI.g_scale.y
	return height
end

function GUI.getList(ltype)
	local list = gui_list[ltype] or {}
	return list
end

function GUI.flagBool(flag)
	local b = false
	if 1 == flag then
		b = true
	end
	return b
end

function GUI.getOriginData(key, ltype)
	local list = GUI.getList(ltype)
	local info = list[key]
	assert(nil ~= info, 'ERROR GUI.getOriginData key [' .. key .. '] is nil')
	local data = {}
	data.key = info.key
	data.fname1 = info.filename1
	data.fname2 = info.filename2
	data.x = info.x * GUI.g_scale.x
	data.y = info.y * GUI.g_scale.y
	data.ox = info.x
	data.oy = info.y
	data.rwidth = info.width
	data.rheight = info.height
	data.width = info.width * GUI.g_scale.x
	data.height = info.height * GUI.g_scale.y
	data.zorder = info.zorder
	data.istoggle = GUI.flagBool(info.istoggle)
	data.label1 = info.label1
	data.label2 = info.label2
	data.owidth = info.owidth
	data.oheight = info.oheight
	data.r = info.r
	data.g = info.g
	data.b = info.b
	data.sr = info.sr
	data.sg = info.sg
	data.sb = info.sb
	return data
end

function GUI.sfactorPos(sfactor, data)
	local size = SCREEN_SIZE_REF
	local scale = data.width/data.rwidth
	local x = data.ox
	local y
	if sfactor == ANCHOR_NULL then
		x = data.x + data.width/2 - data.rwidth/2
		y = data.y + data.height/2 - data.rheight/2
		local hscale = data.height / data.rheight
		if hscale < scale then
			scale = hscale
		end
	elseif sfactor == ANCHOR_DOWN then
		y = data.oy
	elseif sfactor == ANCHOR_UP then
		y = FULL_HEIGHT - (size.height - (data.oy + data.rheight) + data.rheight) * scale
	else -- elseif sfactor == ANCHOR_CENTER then
		local hscale = data.height / data.rheight
		if hscale < scale then
			scale = hscale
		end
		x = GUI.HALF_WIDTH - (size.width / 2 - data.ox) * scale
		y = GUI.FULL_HEIGHT - (size.height - (data.oy + data.rheight) + data.rheight) * scale
	end
	local npos = cc.p(x, y)
	return npos, scale
end

function GUI.getData(key, ltype, sfactor)
	local ndata = {}
	local data = GUI.getOriginData(key, ltype)
	if nil == sfactor then
		return data, nil
	end
	local pos, scale = GUI.sfactorPos(sfactor, data)
	for k, v in pairs(data) do
		ndata[k] = v
	end
	ndata.x = pos.x
	ndata.y = pos.y
	ndata.width = data.rwidth * scale
	ndata.height = data.rheight * scale
	return ndata, scale
end

function GUI.createScale9Sprite(filename, fullrect, insetrect, realsize)
	local sprite = ccui.Scale9Sprite:create(filename, fullrect, insetrect)
	sprite:setContentSize(realsize)
	return sprite
end

function GUI.createScale9Frame(filename, fullrect, insetrect, realsize)
	local sprite = cc.Scale9Sprite:create(filename, fullrect, insetrect)
	sprite:setContentSize(realsize)
	return sprite
end

function GUI.addScale9Sprite(layer, filename, pos, anchorpoint, fullrect, insetrect, realsize, zorder)
	anchorpoint = anchorpoint or GUI.ANCHOR_CENTER_CENTER
	local sprite = GUI.createScale9Sprite(filename,fullrect,insetrect,realsize)
	sprite:setAnchorPoint(anchorpoint)
	if nil ~= pos then
		sprite:setPosition(pos)
	end
	if nil ~= zorder then
		layer:addChild(sprite, zorder)
	else
		layer:addChild(sprite)
	end
	return sprite
end

function GUI.createSprite(filename)
	local cache = cc.Director:getInstance():getTextureCache()
	local texture = cache:addImage(filename)
	local sprite = cc.Sprite:createWithTexture(texture)
	return sprite
end

function GUI.addSprite(layer, filename, pos, anchorpoint, zorder)
	anchorpoint = anchorpoint or GUI.ANCHOR_CENTER_CENTER
	local sprite = GUI.createSprite(filename)
	sprite:setAnchorPoint(anchorpoint)
	if nil ~= pos then
		sprite:setPosition(pos)
	end
	if nil ~= zorder then
		layer:addChild(sprite, zorder)
	else
		layer:addChild(sprite)
	end
	return sprite
end

function GUI.addSpriteByData(layer, key, ltype, sfactor, offsety, offsetheight)
	offsety = offsety or 0
	offsetheight = offsetheight or 0
	local data, scale = GUI.getData(key, ltype, sfactor)
	local fname = data.fname1
	local pos = cc.p(data.x, data.y + offsety)
	local anchor = GUI.ANCHOR_LEFT_DOWN
	local width = data.width
	local height = data.height + offsetheight
	data.y = pos.y
	data.height = height
	local sprite = nil
	local path = Util.getPath(fname)
	if 0 == data.owidth then
		sprite = GUI.addSprite(layer, path, pos, anchor, data.zorder)
	else
		local w = data.owidth
		local h = data.oheight
		local frect = cc.rect(0, 0, w, h) -- fullrect
		local irect = cc.rect(w/2-2, h/2-2, 4, 4) -- insetrect
		local rsize = cc.size(width, height) -- realsize
		sprite = GUI.addScale9Sprite(layer, path, pos, anchor, frect, irect, rsize, data.zorder)
		return sprite, data;
	end
	if nil ~= scale then
		sprite:setScale(scale);
	else
		local size = sprite:getContentSize();
		sprite:setScaleX(width/size.width);
		sprite:setScaleY(height/size.height);
	end
	return sprite, data;
end

function GUI.addSpriteOnCellByData(cell, cdata, key, ltype, sfactor)
	local sprite, data = GUI.addSpriteByData(cell, key, ltype, sfactor)
	local x, y = sprite:getPosition()
	local pos = cc.p(x - cdata.x, y - cdata.y)
	sprite:setPosition(pos)
	data.x = pos.x
	data.y = pos.y
	return sprite, data
end

function GUI.addStrokeAliOnCell(cell, cdata, str, fsize, key, ltype, sfactor, alignment_h, alignment_v, color, scolor)
	alignment_h = alignment_h or cc.TEXT_ALIGNMENT_LEFT
	alignment_v = alignment_v or cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM
	local label, data = GUI.addStrokeOnCellByData(cell, cdata, str, fsize, key, ltype, sfactor, color, scolor)
	label:setAlignment(alignment_h, alignment_v)
	return label, data
end

function GUI.addStrokeOnCellByData(cell, cdata, str, fsize, key, ltype, sfactor, color, scolor)
	local label, data = GUI.addStroke(cell, str, fsize, key, ltype, sfactor, color, scolor)
	local x, y = label:getPosition()
	local pos = cc.p(x - cdata.x, y - cdata.y)
	label:setPosition(pos)
	data.x = pos.x
	data.y = pos.y
	return label, data
end

function GUI.addStroke(layer, str, fsize, key, ltype, sfactor, color, scolor)
	local data, scale = GUI.getData(key, ltype, sfactor)
	local pos, width, height
	local pos = cc.p(data.x, data.y)
	local width = data.width
	local height = data.height
	local r = data.r
	local g = data.g
	local b = data.b
	color = color or cc.c4b(r, g, b, 255)
	local sr = data.sr
	local sg = data.sg
	local sb = data.sb
	scolor = scolor or cc.c4b(sr, sg, sb, 255)
	local outline_size = 2
	-- kelton:
	-- height * 2 is for fit the string while the font size is too large
	--local label = GUI.addLabelOutline(layer, str, nil, fsize, pos, color, scolor, outline_size, GUI.ANCHOR_LEFT_DOWN, data.zorder, cc.size(width, height*2), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM)
	local label = GUI.addLabelOutline(layer, str, nil, fsize, pos, color, scolor, outline_size, GUI.ANCHOR_LEFT_DOWN, data.zorder, cc.size(width, height), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM)
	label:setScale(scale)
	return label, data
end

function GUI.addLabelTTF(layer, text, font, size, pos, color, anchorpoint, zorder, dimensions, halignment, valignment)
	--print('text: ', text)
	--return Util.add_labelsys(layer, text, 'Helvetica', size, pos, color, anchorpoint, zorder, dimensions, halignment, valignment)
	font = font or Util.getPath("zpixel2_ex.ttf")
	--font = font or Util.get_path("JDJZONGYI_0.ttf")
	local label
	if nil == dimensions then
		label = cc.Label:createWithTTF(text, font, size)
	else
		label = cc.Label:createWithTTF(text, font, size, dimensions, halignment, valignment)
	end
	label:setAnchorPoint(anchorpoint)
	label:setPosition(pos)
	--label:setColor(color) -- c3b
	--label:setTextColor(cc.c4b(color.r, color.g, color.b, 255))
	label:setTextColor(color) -- c4b

	if nil ~= zorder then
		layer:addChild(label, zorder)
	else
		layer:addChild(label)
	end

	return label
end

function GUI.addLabelBMF(layer, text, font_path, pos, anchorpoint, zorder, halignment, size, max_line_width, image_offset)
	halignment = halignment or cc.TEXT_ALIGNMENT_LEFT
	max_line_width = max_line_width or 0
	image_offset = image_offset or cc.p(0, 0)
	local width = 0
	if nil ~= size then
		width = size.width
	end
	local label = cc.Label:createWithBMFont(font_path, text, halignment, max_line_width, image_offset)
	if halignment == cc.TEXT_ALIGNMENT_RIGHT and width > 0 then
		label:setPosition(cc.p(pos.x+width, pos.y))
		label:setAnchorPoint(ANCHOR_RIGHT_DOWN)
	elseif halignment == cc.TEXT_ALIGNMENT_CENTER and width > 0 then
		label:setPosition(cc.p(pos.x+width/2, pos.y))
		label:setAnchorPoint(GUI.ANCHOR_CENTER_DOWN)
	else
		label:setPosition(pos)
		label:setAnchorPoint(anchorpoint)
	end

	if nil ~= zorder then
		layer:addChild(label, zorder)
	else
		layer:addChild(label)
	end

	return label
end

-- cc.TEXT_ALIGNMENT_LEFT
-- cc.TEXT_ALIGNMENT_CENTER
-- cc.TEXT_ALIGNMENT_RIGHT
-- cc.VERTICAL_TEXT_ALIGNMENT_TOP
-- cc.VERTICAL_TEXT_ALIGNMENT_CENTER
-- cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM
function GUI.addLabelSys(layer, text, font, size, pos, color, anchorpoint, zorder, dimensions, halignment, valignment)
	local label
	if nil == dimensions then
		label = cc.Label:createWithSystemFont(text, font, size)
	else
		label = cc.Label:createWithSystemFont(text, font, size, dimensions, halignment, valignment)
	end
	label:setAnchorPoint(anchorpoint)
	label:setPosition(pos)
	label:setColor(color)

	if nil ~= zorder then
		layer:addChild(label, zorder)
	else
		layer:addChild(label)
	end

	return label
end

function GUI.addLabel(layer, text, size, pos, color, anchorpoint, zorder, dimensions, halignment, valignment)
	local label
	label = GUI.addLabelSys(layer, text, "Arial", size, pos, color, anchorpoint, zorder, dimensions, halignment, valignment)
	return label
end

function GUI.addLabelByData(layer, str, fsize, key, ltype, sfactor, color, offsety, offsetheight)
	local alignment = cc.TEXT_ALIGNMENT_LEFT
	local label, data = GUI.addLabelAliByData(layer, str, fsize, key, ltype, sfactor, alignment, color, offsety, offsetheight)
	return label, data
end

function GUI.addLabelGlow(layer, text, font, size, pos, color, glow_color, anchorpoint, zorder, dimensions, halignment, valignment)
	local label = GUI.addLabelConfig(layer, text, font, size, pos, color, anchorpoint, zorder, dimensions, halignment, valignment)
	label:enableGlow(glow_color)
	return label
end

function GUI.addLabelGlowByData(layer, str, fsize, color, glow_color,key,ltype,sfactor)
	local data, scale = GUI.getData(key, ltype, sfactor)
	local pos, width, height
	local pos = cc.p(data.x, data.y)
	local width = data.width
	local height = data.height
	local label = GUI.addLabelGlow(layer, str, nil, fsize, pos, color, glow_color, GUI.ANCHOR_LEFT_DOWN, data.zorder, cc.size(width, height), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM)
	label:setScale(scale)
	return label, data
end

function GUI.addLabelShadow(layer, text, font, size, pos, color, shadow_color, anchorpoint, zorder, dimensions, halignment, valignment)
	local label = GUI.addLabelConfig(layer, text, font, size, pos, color, anchorpoint, zorder, dimensions, halignment, valignment)
	label:enableShadow(shadow_color)
	return label
end

function GUI.addLabelOutline(layer, text, font, size, pos, color, outline_color, outline_size, anchorpoint, zorder, dimensions, halignment, valignment)
	local label = GUI.addLabelConfig(layer, text, font, size, pos, color, anchorpoint, zorder, dimensions, halignment, valignment)
	label:enableOutline(outline_color, outline_size)
	return label
end

function GUI.addLabelConfig(layer, text, font, size, pos, color, anchorpoint, zorder, dimensions, halignment, valignment)
	font = font or Util.getPath("zpixel2_ex.ttf")

	-- distanceFieldEnabled should be true if to use glow
	-- if outlineSize > 0 then distanceFieldEnabled will be false
	local ttfConfig = { 
		fontFilePath = font, 
		fontSize = size,
		glyphs = cc.GLYPHCOLLECTION_DYNAMIC,
		customGlyphs = nil,
		distanceFieldEnabled = false,
		outlineSize = 0,
	};
	local label = cc.Label:create()
	label:setTTFConfig(ttfConfig)
	label:setString(text)
	label:setAnchorPoint(anchorpoint)
	label:setPosition(pos)
	label:setTextColor(color)
	if nil ~= dimensions then
		label:setDimensions(dimensions.width, dimensions.height)
	end
	if nil ~= halignment and nil ~= valignment then
		label:setAlignment(halignment, valignment)
	end
	-- e.g --> outline
	-- local outline_color = cc.c4b(0, 0, 255, 255)
	-- local outline_size = 1
	-- label:enableOutline(outline_color, outline_size)
	-- e.g --> glow
	-- label:enableGlow(cc.c4b(255, 255, 0, 255))

	if nil ~= zorder then
		layer:addChild(label, zorder)
	else
		layer:addChild(label)
	end

	return label
end

function GUI.addLabelOutlineByData(layer, str, fsize,color,outline_color,outline_size,key,ltype,sfactor)
	local data, scale = GUI.getData(key, ltype, sfactor)
	local pos, width, height
	local pos = cc.p(data.x, data.y)
	local width = data.width
	local height = data.height
	local label = GUI.addLabelOutline(layer, str, nil, fsize, pos, color, outline_color, outline_size, GUI.ANCHOR_LEFT_DOWN, data.zorder, cc.size(width, height), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM)
	label:setScale(scale)
	return label, data
end

function GUI.addLabelOutBlackByData(layer, str, fsize, key, ltype, sfactor, color)
	local data, scale = GUI.getData(key, ltype, sfactor)
	local pos, width, height
	local pos = cc.p(data.x, data.y)
	local width = data.width
	local height = data.height
	local r = data.r
	local g = data.g
	local b = data.b
	color = color or cc.c4b(r, g, b, 255)
	local outline_color = GUI.c4b_black
	local outline_size = 1
	local label = GUI.addLabelOutline(layer, str, nil, fsize, pos, color, outline_color, outline_size, GUI.ANCHOR_LEFT_DOWN, data.zorder, cc.size(width, height), cc.TEXT_ALIGNMENT_LEFT, cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM)
	label:setScale(scale)
	return label, data
end

function GUI.addLabelOnCell(cell, cdata, str, fsize, key, ltype, sfactor, color)
	local label, data = GUI.addLabelByData(cell, str, fsize, key, ltype, sfactor, color)
	local x, y = label:getPosition()
	local pos = cc.p(x - cdata.x, y - cdata.y)
	label:setPosition(pos)
	data.x = pos.x
	data.y = pos.y
	return label, data
end

function GUI.addLabelAliByData(layer, str, fsize, key, ltype, sfactor, alignment, color, offsety, offsetheight)
	offsety = offsety or 0
	offsetheight = offsetheight or 0;
	local data, scale = GUI.getData(key, ltype, sfactor)
	scale = scale or 1;
	local pos, width, height;
	local pos = cc.p(data.x, data.y + offsety);
	local width = data.width;
	local height = data.height + offsetheight;
	local r = data.r;
	local g = data.g;
	local b = data.b;
	color = color or cc.c4b(r, g, b, 255);
	local label = GUI.addLabelTTF(layer, str, nil, fsize, pos, color, GUI.ANCHOR_LEFT_DOWN, data.zorder, cc.size(width, height), alignment, cc.VERTICAL_TEXT_ALIGNMENT_BOTTOM);
	label:setScale(scale);
	data.y = pos.y;
	data.height = height;
	return label, data;
end

function GUI.addLabelAliOnCell(cell, cdata, str, fsize, key, ltype, sfactor, alignment, color)
	local label, data = GUI.addLabelAliByData(cell, str, fsize, key, ltype, sfactor, alignment, color);
	local x, y = label:getPosition();
	local pos = cc.p(x - cdata.x, y - cdata.y);
	label:setPosition(pos);
	data.x = pos.x;
	data.y = pos.y;
	return label, data;
end

function GUI.addEditBox(layer, fullpath, fullrect, insetrect, realsize, anchorpoint, pos, font, f_size, f_color, input_mode, return_type, input_flag, handler, max_length, place_holder, place_holder_color, zorder)
	local sprite = GUI.createScale9Sprite(fullpath, fullrect, insetrect, realsize)
	local editbox = ccui.EditBox:create(realsize, sprite)
	editbox:setAnchorPoint(anchorpoint)
	editbox:setPosition(pos)
	editbox:setFontName(font)
	if nil ~= f_size then
		editbox:setFontSize(f_size)
	end
	if nil ~= input_flag then
		editbox:setInputFlag(input_flag)
	end
	editbox:setFontColor(f_color)
	editbox:setPlaceHolder(place_holder or '')
	editbox:setPlaceholderFontColor(place_holder_color or GUI.c_white)
	editbox:setMaxLength(max_length)
	editbox:setInputMode(input_mode)
	editbox:setReturnType(return_type)
	editbox:registerScriptEditBoxHandler(handler)
	if nil ~= layer.getTouchPriority then
		local priority = layer:getTouchPriority()
		editbox:setTouchPriority(priority - 2)
	end
	layer:addChild(editbox, (zorder or -1))

	return editbox
end -- GUI.addEditBox 

function GUI.addEditBoxByData(layer, key, ltype, sfactor, fsize, callback, max_length, place_holder, color)
	local data, scale = GUI.getData(key, ltype, sfactor)
	local pos = cc.p(data.x, data.y + data.height / 2)
	local size = cc.size(data.width, data.height)
	color = color or cc.c3b(data.r, data.g, data.b)
	local editbox = GUI.addEditboxBlank(layer, size, GUI.ANCHOR_LEFT_CENTER, 
		pos, GUI.f_default, fsize, color, cc.EDITBOX_INPUT_MODE_SINGLELINE, 
		cc.KEYBOARD_RETURNTYPE_DONE, nil, callback, max_length, place_holder,
		color, data.zorder)
	return editbox, data
end

function GUI.addEditBoxBlank(layer, realsize, anchorpoint, pos, font, f_size, f_color, input_mode, return_type, input_flag, handler, max_length, place_holder, place_holder_color, zorder)
	local fullrect = cc.rect(0, 0, 64, 64)
	local insetrect = cc.rect(2, 2, 60, 60)
	local path = Util.getPath('blank.png')

	return GUI.addEditBox(layer, path, fullrect, insetrect, realsize, anchorpoint, pos, font, f_size, f_color, input_mode, return_type, input_flag, handler, max_length, place_holder, place_holder_color, zorder)
end -- GUI.addEditBoxBlank 

function GUI.getDataOnCell(cdata, key, ltype, sfactor)
	local data, scale = GUI.getData(key, ltype, sfactor)
	data.x = data.x - cdata.x
	data.y = data.y - cdata.y
	return data, scale
end

function GUI.addItemByData(items, key, ltype, callback, sfactor, offsety, offsetheight)
	offsety = offsety or 0
	offsetheight = offsetheight or 0
	local data, scale = GUI.getData(key, ltype, sfactor)
	local fname1 = data.fname1
	local fname2 = data.fname2
	local mark = true
	if true ~= Util.checkFile(fname2) then
		fname2 = fname1
		mark = false
	end
	local width = data.width
	local height = data.height + offsetheight
	local path, path1, path2, sprite, unsprite, size
	path1 = Util.getPath(fname1)
	path2 = Util.getPath(fname2)
	if 0 == data.owidth then
		unsprite = GUI.createSprite(path1)
		sprite = GUI.createSprite(path2)
	else
		local w = data.owidth
		local h = data.oheight
		local frect = cc.rect(0, 0, w, h) -- fullrect
		local irect = cc.rect(w/2-2, h/2-2, 4, 4) -- insetrect
		local rsize = cc.size(width, height) -- realsize
		unsprite = GUI.createScale9Sprite(path1, frect, irect, rsize)
		sprite = GUI.createScale9Sprite(path2, frect, irect, rsize)
	end

	local label1 = data.label1
	local label2 = data.label2
	if nil ~= unsprite and nil ~= label1 and '0' ~= label1 then
		if nil==label2 or '0'==label2 or true~=Util.checkFile(label2) then
			label2 = label1
		end
		path = Util.getPath(label1)
		local p = cc.p(data.rwidth / 2, data.rheight / 2)
		GUI.addSprite(unsprite, path, p, GUI.ANCHOR_CENTER_CENTER, 1)
	end
	if nil ~= sprite and nil ~= label2 and '0' ~= label2 then
		path = Util.getPath(label2)
		local p = cc.p(data.rwidth / 2, data.rheight / 2)
		GUI.addSprite(sprite, path, p, GUI.ANCHOR_CENTER_CENTER, 1)
	end

	local pos = cc.p(data.x, data.y + offsety)
	data.y = pos.y
	data.height = height
	local anchor = GUI.ANCHOR_LEFT_DOWN
	
	local item
	if true == data.istoggle then
		item = GUI.createToggleSprite(unsprite, sprite, pos, anchorpoint, callback)
	else
		if true ~= mark then
			sprite:setScale(1.1)
		end
		item = GUI.createItemSprite(unsprite, sprite, pos, anchorpoint, callback)
	end
	if 0 == data.owidth then
		if nil ~= scale then
			item:setScale(scale)
		else
			local size = item:getContentSize()
			item:setScaleX(width/size.width)
			item:setScaleY(height/size.height)
		end
	end
	if nil ~= items then
		table.insert(items, item)
	end
	return item, data
end

function GUI.addItemOnCell(items, cdata, key, ltype, callback, sfactor)
	local item, data = GUI.addItemByData(items, key, ltype, callback, sfactor)
	local x, y = item:getPosition()
	local pos = cc.p(x - cdata.x, y - cdata.y)
	item:setPosition(pos)
	data.x = pos.x
	data.y = pos.y
	return item, data
end

function GUI.addCustomItem(items, unsprite, sprite, pos, anchorpoint, callback, title, font, fsize)
	local item = GUI.createItemSprite(unsprite, sprite, pos, anchorpoint, callback);
	table.insert(items, item)
	if nil == title then
		return item
	end
	local size = item:getContentSize()
	local label = GUI.addLabelTTF(item, title, nil, fsize, cc.p(size.width/2, size.height/2), cc.c4b(255, 255, 255, 255), GUI.ANCHOR_CENTER_CENTER, 10, size, cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	label:setTag(TAG_SPRITE_LABEL)
	return item
end

function GUI.addItem1(items, title, font, fsize, callback, anchorpoint, pos, size)
	local fname1 = 'btn_140.png'
	local fname2 = 'btn_140_s.png'
	local frect = cc.rect(0, 0, 106, 53) -- fullrect
	local irect = cc.rect(50, 25, 6, 3) -- insetrect
	size = size or cc.size(150, 53) -- realsize
	local path1 = Util.getPath(fname1)
	local path2 = Util.getPath(fname2)
	local unsprite = GUI.createScale9Sprite(path1,frect,irect,size)
	local sprite = GUI.createScale9Sprite(path2,frect,irect,size)
	return GUI.addCustomItem(items, unsprite, sprite, pos, anchorpoint, callback, title, font, fsize)
end

function GUI.addItem2(items, fname1, fname2, callback, anchorpoint, pos, scale)
	local path1 = Util.getPath(fname1)
	local path2 = Util.getPath(fname2)
	local unsprite = GUI.createSprite(path1)
	local sprite = GUI.createSprite(path2)
	local item = GUI.addCustomItem(items,unsprite,sprite,pos,anchorpoint,callback)
	if nil ~= scale then
		item:setScale(item)
	end
	return item
end

function GUI.addItem3(items, title, font, fsize, callback, anchorpoint, pos, size)
	local fname1 = 'btn_142.png'
	local fname2 = 'btn_142_s.png'
	local frect = cc.rect(0, 0, 148, 54) -- fullrect
	local irect = cc.rect(70, 25, 8, 4) -- insetrect
	size = size or cc.size(172, 62) -- realsize
	local path1 = Util.getPath(fname1)
	local path2 = Util.getPath(fname2)
	local unsprite = GUI.createScale9Sprite(path1,frect,irect,size)
	local sprite = GUI.createScale9Sprite(path2,frect,irect,size)
	--return add_custom_item(items, unsprite, sprite, pos, anchorpoint, callback, title, font, fsize)
	local item = GUI.createItemSprite(unsprite, sprite, pos, anchorpoint, callback)
	table.insert(items, item)
	local size = item:getContentSize()
	local label = GUI.addLabelOutline(item, title, nil, fsize, cc.p(size.width/2, size.height/2), cc.c4b(255, 255, 255, 255), cc.c4b(36, 69, 8, 255), 2, GUI.ANCHOR_CENTER_CENTER, 10, size, cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	label:setTag(GUI.TAG_SPRITE_LABEL)
	return item
end

function GUI.addItem4(items, title, font, fsize, callback, anchorpoint, pos, size)
	local fname1 = 'btn_147.png'
	local fname2 = 'btn_147_s.png'
	local frect = cc.rect(0, 0, 54, 54) -- fullrect
	local irect = cc.rect(25, 25, 4, 4) -- insetrect
	size = size or cc.size(125, 60) -- realsize
	local path1 = Util.getPath(fname1)
	local path2 = Util.getPath(fname2)
	local unsprite = GUI.createScale9Sprite(path1,frect,irect,size)
	local sprite = GUI.createScale9Sprite(path2,frect,irect,size)
	local item = GUI.createItemSprite(unsprite, sprite, pos, anchorpoint, callback)
	table.insert(items, item)
	local size = item:getContentSize()
	local label = GUI.addLabelOutline(item, title, nil, fsize, cc.p(size.width/2, size.height/2), cc.c4b(255, 255, 255, 255), cc.c4b(78, 65, 83, 255), 2, GUI.ANCHOR_CENTER_CENTER, 10, size, cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	label:setTag(GUI.TAG_SPRITE_LABEL)
	return item
end

function GUI.addItemClose(items, pos, anchorpoint, callback)
	local fname1 = 'btn_16.png'
	local fname2 = 'btn_16_s.png'
	local path1 = Util.getPath(fname1)
	local path2 = Util.getPath(fname2)
	local unsprite = GUI.createSprite(path1)
	local sprite = GUI.createSprite(path2)
	return GUI.addCustomItem(items, unsprite, sprite, pos, anchorpoint, callback)
end

function GUI.createToggleSprite(unselect_s, select_s, pos, anchorpoint,callback)
	local toggle
	local item1, item2

	item1 = cc.MenuItemSprite:create(unselect_s, unselect_s)
	toggle = cc.MenuItemToggle:create(item1)

	item2 = cc.MenuItemSprite:create(select_s, select_s)
	toggle:addSubItem(item2)

	anchorpoint = anchorpoint or GUI.ANCHOR_LEFT_DOWN
	toggle:setAnchorPoint(anchorpoint)
	toggle:setPosition(pos)
	if nil ~= callback then
		toggle:registerScriptTapHandler(callback)
	end
	return toggle
end

function GUI.createItemImage(fname1, fname2, pos, anchorpoint, callback)
	local unselectsprite = GUI.createSprite(fname1)
	local selectsprite = GUI.createSprite(fname2 or fname1)
	if fname1 == fname2 then
		selectsprite:setScale(1.1)
	end

	return GUI.createItemSprite(unselectsprite, selectsprite, pos, anchorpoint, callback)
end

function GUI.createItemSprite(unselect_s, select_s, pos, anchorpoint, callback) 
	anchorpoint = anchorpoint or GUI.ANCHOR_LEFT_DOWN
	local item = cc.MenuItemSprite:create(unselect_s, select_s)
	item:setAnchorPoint(anchorpoint)
	item:setPosition(pos)
	if nil ~= callback then
		--[[
		local mm = 0;
		local function cb()
			print('cb');
			mm = mm + 1;
		print('mm: ', mm);
			if mm < 10 then return; end
			item:unscheduleUpdate();
			--callback(item:getTag(), item);
		local t = 0;
		for i = 1, 10000000000 do
			t = t + i;
			--print('t: ', t);
		end
		end
		local function delay_it()
			print('delay_it');
			item:scheduleUpdateWithPriorityLua(cb, 1);
		end
		item:registerScriptTapHandler(delay_it);
		]]--
		item:registerScriptTapHandler(callback)
	end
	return item
end

function GUI.createItemLabel(label, pos, anchorpoint, callback) 
	anchorpoint = anchorpoint or GUI.ANCHOR_LEFT_DOWN
	local item = cc.MenuItemLabel:create(label)
	item:setAnchorPoint(anchorpoint)
	item:setPosition(pos)
	if nil ~= callback then
		item:registerScriptTapHandler(callback)
	end
	return item
end

function GUI.addTextToSprite(parent, text, size, color, pos, anchorpoint,scale)
	local label = parent:getChildByTag(GUI.TAG_SPRITE_LABEL)
	if nil ~= label then
		label:removeFromParentAndCleanup(true)
		label = nil
	end
	local psize = parent:getContentSize()
	local pscale = parent:getScale()
	local width = psize.width * pscale
	local height = psize.height * pscale
	pos = pos or cc.p(width / 2, height / 2)
	anchorpoint = anchorpoint or GUI.ANCHOR_CENTER_CENTER
	local label = GUI.addLabelTTF(parent, text, nil, size, pos, color, anchorpoint, 1, cc.size(width, height), cc.TEXT_ALIGNMENT_CENTER, cc.VERTICAL_TEXT_ALIGNMENT_CENTER)
	label:setTag(GUI.TAG_SPRITE_LABEL)
	return label
end

function GUI.addTextToSpriteByData(parent, data, text, size, outline_size)
	local color = cc.c4b(data.r, data.g, data.b, 255)
	return GUI.addTextToSprite(parent, text, size, color)
end

function GUI.addTextOnSprite(sprite, text, key, ltype, sfactor, size, color)
	local data = GUI.getData(key, ltype, sfactor)
	color = color or cc.c4b(data.r, data.g, data.b, 255)
	local label = GUI.addTextToSprite(sprite, text, size, color)
	return label, data
end

function GUI.addTextOnSprite2(sprite, text, data, size, color)
	color = color or cc.c3b(data.r, data.g, data.b)
	local label = GUI.addTextToSprite(sprite, text, size, color)
	return label
end

function GUI.addTextOutlineOnSpriteByData(sprite, text, key, ltype, sfactor, size, color, outline_color)
	local data = GUI.getData(key, ltype, sfactor)
	color = color or cc.c4b(data.r, data.g, data.b, 255)
	outline_color = outline_color or cc.c4b(data.sr, data.sg, data.sb, 255)
	local label = GUI.addTextOutlineToSprite(sprite, text, size, color, outline_color, 2)
	return label, data
end

function GUI.addMenu(layer, list_item, zorder, priority) -- {
	list_item = list_item or {}
	if 0 == #list_item then
		return
	end
	zorder = zorder or Touch.ZORDER_MENU

	local menu = cc.Menu:create()
	for i = 1, #list_item do
		local item = list_item[i]
		menu:addChild(item)
	end
	menu:setAnchorPoint(GUI.ANCHOR_LEFT_DOWN)
	menu:setPosition(0, 0)

	layer:addChild(menu, zorder) -- hard code, always on top of layer
	if nil == priority and nil ~= layer.getTouchPriority then
		priority = layer:getTouchPriority()
	end
	if nil ~= priority then
		-- always before the layer (touchable)
		menu:setTouchPriority(priority - 2)
	end

	return menu -- return btn is for reference only, do not use
end -- GUI.addMenu }

-- direction
-- cc.SCROLLVIEW_DIRECTION_NONE
-- cc.SCROLLVIEW_DIRECTION_HORIZONTAL
-- cc.SCROLLVIEW_DIRECTION_VERTICAL
-- cc.SCROLLVIEW_DIRECTION_BOTH
-- fillorder
-- cc.TABLEVIEW_FILL_TOPDOWN
-- cc.TABLEVIEW_FILL_BOTTOMUP
function GUI.addTableView(layer, size, direction, handler, pos, fillorder, zorder)
	local tableview = cc.TableView:create(size)
	tableview:setDirection(direction)
	tableview:setPosition(pos)
	tableview:setVerticalFillOrder(fillorder)
	tableview:setDelegate()
	tableview:registerScriptHandler(
		function(view)
			return handler("numberOfCellsInTableView", view)
			--TableViewTestLayer.numberOfCellsInTableView
			-- return num;
		end,
		cc.NUMBER_OF_CELLS_IN_TABLEVIEW
	)
	tableview:registerScriptHandler(
		function(view)
			return handler("scrollViewDidScroll", view)
			--TableViewTestLayer.scrollViewDidScroll
		end,
		cc.SCROLLVIEW_SCRIPT_SCROLL
	)
	tableview:registerScriptHandler(
		function(view)
			return handler("scrollViewDidZoom", view)
			--TableViewTestLayer.scrollViewDidZoom
		end,
		cc.SCROLLVIEW_SCRIPT_ZOOM
	)
	tableview:registerScriptHandler(
		function(view, cell)
			return handler("tableCellTouched", view, cell)
			--TableViewTestLayer.tableCellTouched
		end,
		cc.TABLECELL_TOUCHED
	)
	tableview:registerScriptHandler(
		function(view, idx)
			return handler("cellSizeForTable", view, idx)
			--TableViewTestLayer.cellSizeForTable
			-- return len
		end,
		cc.TABLECELL_SIZE_FOR_INDEX
	)
	tableview:registerScriptHandler(
		function(view, idx)
			return handler("tableCellAtIndex", view, idx)
			--TableViewTestLayer.tableCellAtIndex
		end,
		cc.TABLECELL_SIZE_AT_INDEX
	)
	tableview:registerScriptHandler(
		function(view, cell)
			return handler("tableCellHighlight", view, cell)
		end,
		cc.TABLECELL_HIGH_LIGHT
	)
	tableview:registerScriptHandler(
		function(view, cell)
			return handler("tableCellUnhighlight", view, cell)
		end,
		cc.TABLECELL_UNHIGH_LIGHT
	)
	if nil == zorder then
		layer:addChild(tableview)
	else
		layer:addChild(tableview, zorder)
	end
	tableview:reloadData()
	return tableview
end

function GUI.addTableViewScrollBar(layer, pos, size, anchorpoint, zorder)
	local fullpath = Util.getFullPath(GUI.F_IMAGE, 'scroll_bar.png')
	local fullrect = cc.rect(0, 0, 32, 64)
	local insetrect = cc.rect(15, 27, 2, 10)
	local realsize = cc.size(32, size.height)
	local bar = GUI.addScale9Sprite(layer, fullpath, pos, anchorpoint, fullrect, insetrect, realsize, zorder)

	fullpath = Util.getFullPath(GUI.F_IMAGE, 'scroll_bar_tap.png')
	pos = cc.p(bar:getContentSize().width / 2, 0)
	local tap = GUI.addSprite(bar, fullpath, pos, GUI.ANCHOR_CENTER_CENTER, 50)

	bar:setVisible(false)
	return bar, tap
end

function GUI.handleTableViewScrollBar(tableview, bar, tap)
	local theight = tableview:getContentSize().height
	local offset = tableview:getContentOffset()
	local bheight = bar:getContentSize().height
	if theight < bheight then
		if true == bar:isVisible() then bar:setVisible(false) end
		return
	else
		if false == bar:isVisible() then bar:setVisible(true) end
	end
	local ff = (-offset.y) / (theight - bheight)
	if ff < 0 then
		ff = 0
	end
	if ff > 1 then
		ff = 1
	end
	local newy = ff * bheight
	tap:setPositionY(newy)
	bar:stopAllActions()
	local array = {}
	table.insert(array, cc.DelayTime:create(1))
	table.insert(array, cc.Hide:create())
	bar:runAction(cc.Sequence:create(array))
end

function GUI.addArrows(parent, tpos, tsize, cwidth, list_len, offset)
	local left_arrow, right_arrow
	local function btn_action(btn)
		local c = btn:getColor()
		local array = {}
		local action = cc.TintTo:create(0.5, 150, 150, 40)
		table.insert(array, action)
		action = cc.TintTo:create(0.5, c.r, c.g, c.b)
		table.insert(array, action)
		action = cc.Sequence:create(array)
		action = cc.RepeatForever:create(action)
		btn:runAction(action)
	end

	local items = {}
	local item, path1, path2, pos
	--fullpath = Util.get_fullpath(F_IMAGE, 'l_arrow_1.png')
	path1 = Util.getPath('btn_84.png')
	path2 = Util.getPath('btn_84_s.png')
	pos = cc.p(tpos.x, tpos.y) -- image size: 24x26
	item = GUI.createItemImage(path1, path2, pos, GUI.ANCHOR_LEFT_DOWN, nil)
	pos.y = pos.y + tsize.height/2
	item:setPosition(pos);
	item:setAnchorPoint(GUI.ANCHOR_RIGHT_CENTER)
	left_arrow = item
	table.insert(items, item)

	--fullpath = util.get_fullpath(F_IMAGE, 'r_arrow_1.png');
	--path = util.get_path('btn_4.png');
	path1 = Util.getPath('btn_85.png')
	path2 = Util.getPath('btn_85_s.png')
	pos = cc.p(tpos.x+tsize.width, tpos.y) -- image size: 24x26
	item = GUI.createItemImage(path1, path2, pos, GUI.ANCHOR_LEFT_DOWN, nil)
	pos.y = pos.y + tsize.height/2
	item:setPosition(pos)
	item:setAnchorPoint(GUI.ANCHOR_LEFT_CENTER)
	right_arrow = item
	table.insert(items, item)

	GUI.addMenu(parent, items, 60)

	btn_action(left_arrow)
	btn_action(right_arrow)
	
	GUI.handleArrows(left_arrow, right_arrow, list_len, cwidth, tsize.width, offset or cc.p(0, 0))

	return left_arrow, right_arrow
end

function GUI.handleArrows(clarrow, crarrow, list_len, cell_width, tableview_width, offset)
	if nil == clarrow or nil == crarrow then
		return
	end
	if 0 == list_len then
		clarrow:setVisible(false)
		crarrow:setVisible(false)
		return
	end
	local offsetx = math.floor(offset.x)
	local offsety = math.floor(offset.y)
	local offsetend = math.floor(cell_width * list_len - tableview_width)
	if 0 <= offsetx then
		if true == clarrow:isVisible() then
			clarrow:setVisible(false)
		end
		if 0 == offsetend then
			crarrow:setVisible(false)
		elseif false == crarrow:isVisible() then
			crarrow:setVisible(true)
		end
	elseif -offsetend >= offsetx then
		if false == clarrow:isVisible() then
			clarrow:setVisible(true)
		end
		if true == crarrow:isVisible() then
			crarrow:setVisible(false)
		end
	else
		if false == clarrow:isVisible() then
			clarrow:setVisible(true)
		end
		if false == crarrow:isVisible() then
			crarrow:setVisible(true)
		end
	end
end

function GUI.checkSpriteFrame(filename)
	if nil == filename then
		return false
	end
	local cache = cc.SpriteFrameCache:getInstance()
	local frame = cache:getSpriteFrame(filename)
	if nil ~= frame then
		return true
	end
	return false
end

function GUI.createSpriteFrame(filename)
	if false == GUI.checkSpriteFrame(filename) then
		return nil
	end
	local sprite = cc.Sprite:createWithSpriteFrameName(filename)
	return sprite
end

function GUI.createItemImageFrame(fname1, fname2, pos, anchorpoint, callback)
	local unselectsprite = GUI.createSpriteFrame(fname1)
	local selectsprite = GUI.createSpriteFrame(fname2 or fname1)
	if fname1 == fname2 then
		selectsprite:setScale(1.1)
	end

	return GUI.createItemSprite(unselectsprite, selectsprite, pos, anchorpoint, callback)
end

function GUI.addCellBg(cell, data, width, height)
	width = width or data.width
	height = height or data.height
	local sprite = nil
	local path = Util.getPath(data.fname1)
	local pos = cc.p(0, 0)
	local anchor = GUI.ANCHOR_LEFT_DOWN
	if 0 == data.owidth then
		sprite = GUI.addSprite(cell, path, pos, anchor, data.zorder)
	else
		local w = data.owidth
		local h = data.oheight
		local frect = cc.rect(0, 0, w, h) -- fullrect
		local irect = cc.rect(w/2-2, h/2-2, 4, 4) -- insetrect
		local rsize = cc.size(width, height) -- realsize
		sprite = GUI.addScale9Sprite(cell, path, pos, anchor, frect, irect, rsize, data.zorder)
		return sprite
	end
	if nil ~= scale then
		sprite:setScale(scale)
	else
		local size = sprite:getContentSize()
		sprite:setScaleX(width/size.width)
		sprite:setScaleY(height/size.height)
	end
	return sprite
end

-- scale back and fade in
function GUI.keffShowFromRight(node, delay, time)
	if nil == node then return; end
	local action_tag = 92;
	time = time or 0.2;
	delay = delay or 0;
	local gapx = 60;
	local list = node:getChildren();
	for i = 1, #list do
		local s = list[i];
		s:stopActionByTag(action_tag);
		local x, y = s:getPosition();
		s:setPositionX(x+gapx);
		s:setOpacity(100);
		local array = {};
		local sa = {};
		table.insert(array, cc.DelayTime:create(delay));
		table.insert(sa, cc.FadeIn:create(time));
		table.insert(sa, cc.EaseIn:create(cc.MoveTo:create(time,cc.p(x,y)),time));
		table.insert(array, cc.Spawn:create(sa));
		local action = cc.Sequence:create(array);
		action:setTag(action_tag);
		s:runAction(action);
	end
end

function GUI.showPopAnim(node, callback)
	if nil == node then return end
	local layer_color = node:getChildByTag(GUI.TAG_LAYER_COLOR)
	local size = cc.size(GUI.FULL_WIDTH, GUI.FULL_HEIGHT)
	local fscale = 0.5 -- scale from
	node:setScale(fscale)
	if nil ~= layer_color then
		local s = 1 / fscale
		local nwidth = size.width * s
		local nheight = size.height * s
		layer_color:setPosition(cc.p(-(nwidth-size.width)/2, -(nheight-size.height)/2))
		layer_color:setContentSize(cc.size(nwidth, nheight))
	end
	local list = {}
	table.insert(list, cc.EaseIn:create(cc.ScaleTo:create(0.2, 1.1), 0.2))
	table.insert(list, cc.EaseOut:create(cc.ScaleTo:create(0.15, 1), 0.15))
	if nil ~= layer_color then
		local function reset_color()
			layer_color:setPosition(cc.p(0, 0))
			layer_color:setContentSize(size)
		end
		table.insert(list, cc.CallFunc:create(reset_color))
	end
	if nil ~= callback then
		table.insert(list, cc.CallFunc:create(callback))
	end
	local action = cc.Sequence:create(list)
	node:runAction(action)
end

function GUI.addLayerColor(layer, color, zorder)
	zorder = zorder or 0
	local layer_color = cc.LayerColor:create(color)
	layer_color:setTag(GUI.TAG_LAYER_COLOR)
	layer:addChild(layer_color)
end

function GUI.printData(data)
	print('--------');
		local str = string.format("[%s][%s][%s][%s][%s][%s][%s][%s][%s][%s][%s]", data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10], data[11]);
		print('str : ', str);
	print('--------');
end

return GUI

