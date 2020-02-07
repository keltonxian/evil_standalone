local Net = require("app.base.Net")
local Util = require("app.base.Util")
local Bit = require("app.base.Bit")
local Scene = require("app.base.Scene")

local Tutor = class("Tutor")

local USE_TIP_TUTOR      = false
local OLD_TUTOR          = false

-- tutorial start
-- deprecated --
local TUTOR_FIRST_INTRO    = 1
local TUTOR_CHAPTER_1_1    = 2
local TUTOR_CHAPTER_1_1_R  = 3
local TUTOR_CHAPTER_1_2    = 4
local TUTOR_CHAPTER_1_2_R  = 5
local TUTOR_CHAPTER_1_3    = 6
local TUTOR_CHAPTER_1_3_R  = 7
local TUTOR_RETURN_1_1     = 8
local TUTOR_RETURN_1_7     = 9
local TUTOR_RETURN_1_8     = 10
local TUTOR_DECK_MOVE_CARD = 11
local TUTOR_PIECE_MERGE    = 12
local TUTOR_CHAPTER_1_9    = 13
local TUTOR_RETURN_1_9     = 14
local TUTOR_STAGE_1_9      = 15
local TUTOR_SHOW_PIECE     = 16
--[[
local TUTOR_STORY          = 1
local TUTOR_FIRST_SAC      = 2
local TUTOR_WAIT_NEXT_SAC  = 3
local TUTOR_WAIT_NEXT      = 301
local TUTOR_SECOND_SAC     = 4
local TUTOR_HIGHLIGHT_CARD = 5
local TUTOR_SOMMON_CARD    = 501
local TUTOR_WYLD_SKILL     = 6
local TUTOR_NO_TARGET_ATK  = 601
local TUTOR_REST           = 7
local TUTOR_ATTACK         = 8
local TUTOR_INTRO          = 9
local TUTOR_AREA           = 901
local TUTOR_AREA_RES       = 902
local TUTOR_AREA_HAND      = 903
local TUTOR_AREA_HERO      = 904
local TUTOR_AREA_DECK      = 905
local TUTOR_AREA_SPACE     = 906
local TUTOR_TURN_SAC       = 907
local TUTOR_PVP_CAN_ATTACK = 10
local TUTOR_PVP_ATTACK     = 11
local TUTOR_PAY_AD         = 12
local TUTOR_PAY            = 13
local TUTOR_DECK           = 14
]]--
-- deprecated --

local TUTOR_RES            = 1200
local TUTOR_TAP_CARD       = 1201
local TUTOR_COST           = 1300
local TUTOR_DESC           = 1400
local TUTOR_HERO_POWER     = 1500
local TUTOR_HERO_HP        = 1501
local TUTOR_ALLY_ATTACK    = 1600
local TUTOR_ALLY_HP        = 1601
local TUTOR_WEAPON_ATK     = 1700
local TUTOR_WEAPON_DUR     = 1701
local TUTOR_ARMOR_DEF      = 1800
local TUTOR_ARMOR_DUR      = 1801
local TUTOR_SAC            = 1900
local TUTOR_PLAY           = 2000
local TUTOR_HL             = 2100
local TUTOR_SAC_TAP        = 2200
local TUTOR_USE            = 2300
local TUTOR_HL_ALLY        = 2400
local TUTOR_TAP_ATTACK     = 2500
local TUTOR_HL_ATTARGET    = 2600
local TUTOR_TAP_ATTARGET   = 2700
local TUTOR_HL_HERO        = 2800
local TUTOR_TAP_ABHERO     = 2900
local TUTOR_NEED_RES       = 3000
local TUTOR_NEXT           = 3100
local TUTOR_TAP_SKIP       = 3200
local TUTOR_SOLO           = 3300


local TUTOR_TEST           = 9999
-- > 100 means not mark at g_tutor, should always trigger
-- see util.set_trigger and util.check_trigger
-- tutorial end -- max is 30;

local g_tutor = 0
local g_tutor_change = nil

function Tutor.resetTutor()
	Net:netSend('scourse 0')
end

function Tutor.setTutor(tutor_step, is_done, is_upload)
	if nil == tutor_step then return end
	Util.log('tutuor_step: ' .. tutor_step)
	if tutor_step > 100 then
		return
	end
	local index = Bit.bitLshift(1, tutor_step);
	local mark = g_tutor
	if true == is_done then
		mark = Bit.bitOr(g_tutor, index)
	else
		index = Bit.bitNot(index)
		mark = Bit.bitAnd(g_tutor, index)
	end
	g_tutor = mark
	g_tutor_change = true
	--local cmd = string.format("scourse %d", mark);
	if true == is_upload then
		Tutor.uploadTutor()
	end
	return
end

function Tutor.resetSvgTutor()
	if nil == TUTOR_FIRST_SAC then
		return
	end
	for i = TUTOR_FIRST_SAC, 31 do
		Tutor.set_tutor(i, false, true)
	end
end

function Tutor.uploadTutor()
	if true == USE_TIP_TUTOR then
		return
	end
	if nil == g_tutor_change then
		return
	end
	local cmd = 'scourse ' .. g_tutor
	Net:netSend(cmd, true)
end

function Tutor.tutorLocal()
	local scenePreload = require("app.scene.ScenePreload")
	Scene:preload(Tutor.tutorCbFightInit, scenePreload.START, Scene.STAGE_PVE);
	return true
end

-- ally 130x
function Tutor.tutorCbFightInit()
	--[[
	local side = 1;
	local seed = 31197;
	local timeout = 60;
	local deck_1 = '1000000000000000000004200423040000000000000000000000000000000022102002000000000000000000000000000000000000000000000000000000000000020200000000000000000002400000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
	local deck_2 = '0000000100000000000000404000000000000400000000000000000000000000000000000000000000000000000000440000000000000000000000000000000000000040000000000000000000404003000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000';
	g_scene:pve(side, seed, deck_1, deck_2);
	g_is_in_tutor = true;
	story_1();
	]]--

	local side = 2;
	local my_hero = 1;
	local hero_name = "高手";
	local clist = c_str_array(g_euser.all_str);
	for i = 1, #clist do
		local card = clist[i].card;
		if card.ctype == HERO then
			my_hero = card.id;
			hero_name = card.name;
			break;
		end
	end
	local thn = "安妮";
	local t_icon = 1;
	if hero_list[15] ~= nil then
		local c = hero_list[15];
		thn = c.name;
		t_icon = c.id;
	end
	data_handler:cleanup();
	data_handler:init_side(side); 
	data_handler:init_tables();
	local info = {
		side_up = {
			hero = { 15 },
			deck = { },
			hand = { 79, 45 },
			ally = { 52, 41, 54 },
			support = { 77 },
			grave = { },
		},
		side_down = {
			hero = { my_hero },
			deck = { },
			hand = { 40 },
			ally = { 25, 35, 23, 37 },
			support = { },
			grave = { },
		},
	};
	anim.reset_data();
	logic_init_test(info);
	-- card in deck
	card_init_table(g_logic_table[1][T_DECK], { 45, 78 }, g_logic_table);
	card_init_table(g_logic_table[2][T_DECK], { 40 }, g_logic_table);
	---------------
	g_current_side = 2;
	local hp_up = g_logic_table[1][T_HERO][1].hp;
	local hp_down = g_logic_table[2][T_HERO][1].hp;
	g_logic_table[1][T_HERO][1]:change_hp(-(hp_up-9));
	g_logic_table[2][T_HERO][1]:change_hp(-(hp_down-10));
	g_logic_table[1].resource = 0;
	g_logic_table[1].resource_max = 8;
	g_logic_table[2].resource = 0;
	g_logic_table[2].resource_max = 5;
	g_is_in_tutor = true;
	g_scene:pve_do_scene(side);
	enable_btn(layer_table.btn_chat, false);
	story_data = {};
	story_data.actor = string.format("%s导师", hero_name);
	story_data.icon = my_hero;
	story_data.m_hero = hero_name;
	story_data.t_hero = thn;
	story_data.t_icon = t_icon;
	layer_card:init_wait_action(g_phase);
	story_1();
end

return Tutor

