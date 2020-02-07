
local Touch = class("Touch")

-- zorder start
Touch.ZORDER_CARD_ATTACH      = -130
Touch.ZORDER_MENU             = 1
Touch.ZORDER_CARD             = 15
Touch.ZORDER_COUNT_DECK       = 20
Touch.ZORDER_CARD_TOUCH       = 25
Touch.ZORDER_SHOWING          = 30
Touch.ZORDER_EFFECT           = 40
Touch.ZORDER_CARD_BG          = -100
Touch.ZORDER_CARD_IMAGE       = -120
Touch.ZORDER_CARD_HL          = -125
Touch.ZORDER_CARD_ATTACH      = -130

Touch.ZORDER_LAYER_LOADING    = 50
Touch.ZORDER_LAYER_TOUCH      = 30
Touch.ZORDER_LAYER_HORSELAMP  = 10
Touch.ZORDER_LAYER_DEBUG      = 6
Touch.ZORDER_LAYER_TIP        = 5
Touch.ZORDER_LAYER_MSG        = 4
Touch.ZORDER_LAYER_LTARGET    = 3
Touch.ZORDER_LAYER_MISPOP     = 3
Touch.ZORDER_LAYER_CARDSHOW   = 3
Touch.ZORDER_LAYER_RESULT     = 2
Touch.ZORDER_LAYER_MENU       = 1
Touch.ZORDER_LAYER_DRAGSTORY  = -1
Touch.ZORDER_LAYER_TUTORIAL   = -1
Touch.ZORDER_LAYER_DRAGTUTOR  = -1
Touch.ZORDER_LAYER_ALERT      = -5
Touch.ZORDER_LAYER_TEXT       = -10
Touch.ZORDER_LAYER_MAILTEXT   = -10
Touch.ZORDER_LAYER_NOTICE     = -25
Touch.ZORDER_LAYER_STORY      = -30
Touch.ZORDER_LAYER_DIALOG     = -30
Touch.ZORDER_LAYER_GATEPOP    = -30
Touch.ZORDER_LAYER_INFOBAR    = -30 -- -60;
Touch.ZORDER_LAYER_MISSION    = -30
Touch.ZORDER_LAYER_DAILY      = -30
Touch.ZORDER_LAYER_PAY        = -30
Touch.ZORDER_LAYER_FIGHT      = -35
Touch.ZORDER_LAYER_PRANK_TIP  = -35
Touch.ZORDER_LAYER_VIDEO      = -35
Touch.ZORDER_LAYER_POPCLIST   = -35
Touch.ZORDER_LAYER_PICKICON   = -35
Touch.ZORDER_LAYER_FINDFRD    = -35
Touch.ZORDER_LAYER_CMATCH     = -35
Touch.ZORDER_LAYER_CODE       = -35
Touch.ZORDER_LAYER_LOCK       = -35
Touch.ZORDER_LAYER_CCHANNEL   = -35
Touch.ZORDER_LAYER_CGUILD     = -35
Touch.ZORDER_LAYER_MATCHDATA  = -35
Touch.ZORDER_LAYER_QUICK      = -35
Touch.ZORDER_LAYER_EXCHANGE   = -35
Touch.ZORDER_LAYER_PAY_AD     = -40
Touch.ZORDER_LAYER_INFO       = -40
Touch.ZORDER_LAYER_SHOPPOP    = -40
Touch.ZORDER_LAYER_FORUM      = -40
Touch.ZORDER_LAYER_APPSTOREPAY= -40
Touch.ZORDER_LAYER_SERVICE    = -40
Touch.ZORDER_LAYER_SOLO       = -40
Touch.ZORDER_LAYER_GATE       = -40
Touch.ZORDER_LAYER_LOTTERY    = -40
Touch.ZORDER_LAYER_LMATCH     = -40
Touch.ZORDER_LAYER_TOWER      = -40
Touch.ZORDER_LAYER_CPOS       = -40
Touch.ZORDER_LAYER_APPROVE    = -50
Touch.ZORDER_LAYER_AGUILD     = -50
Touch.ZORDER_LAYER_AINVEST    = -50
Touch.ZORDER_LAYER_CHATPOP    = -50
Touch.ZORDER_LAYER_CHERO      = -60
Touch.ZORDER_LAYER_DECKPOP    = -60
Touch.ZORDER_LAYER_CSERVER    = -60
Touch.ZORDER_LAYER_PICK       = -60
Touch.ZORDER_LAYER_MORE       = -60
Touch.ZORDER_LAYER_BOTTOMBAR  = -60
Touch.ZORDER_LAYER_CONTROL    = -90
Touch.ZORDER_LAYER_CHAT       = -90
Touch.ZORDER_LAYER_GRAVE      = -120	
Touch.ZORDER_LAYER_ANIM       = -150
Touch.ZORDER_LAYER_HEROMISS   = -150
Touch.ZORDER_LAYER_CBOX       = -150
Touch.ZORDER_LAYER_ACTION     = -180	   -- max card, attack/ability/cast button
Touch.ZORDER_LAYER_PREVIEW    = -180
Touch.ZORDER_LAYER_BOOK       = -180
Touch.ZORDER_LAYER_HERO       = -180
Touch.ZORDER_LAYER_ROOM       = -240	
Touch.ZORDER_LAYER_SFRIEND    = -240
Touch.ZORDER_LAYER_SHOP       = -260
Touch.ZORDER_LAYER_TESTC      = -260
Touch.ZORDER_LAYER_TESTLUA    = -260
Touch.ZORDER_LAYER_REGISTER   = -260
Touch.ZORDER_LAYER_GRADE      = -260
Touch.ZORDER_LAYER_MAIL_BOX   = -260
Touch.ZORDER_LAYER_FRIEND     = -260
Touch.ZORDER_LAYER_LROOM      = -260
Touch.ZORDER_LAYER_LWAIT      = -260
Touch.ZORDER_LAYER_CARD       = -260	
Touch.ZORDER_LAYER_STAGE      = -260
Touch.ZORDER_LAYER_PMYSTERY   = -260
Touch.ZORDER_LAYER_MYDECK     = -400
Touch.ZORDER_LAYER_SGDECK     = -400
Touch.ZORDER_LAYER_PIECE      = -400
Touch.ZORDER_LAYER_MYSTERY    = -400
Touch.ZORDER_LAYER_PICKDECK   = -400
Touch.ZORDER_LAYER_CHAPTER    = -400
Touch.ZORDER_LAYER_TABLE      = -400
Touch.ZORDER_LAYER_ROLE       = -400
Touch.ZORDER_LAYER_DECK       = -400
Touch.ZORDER_LAYER_RANK       = -400
Touch.ZORDER_LAYER_PCLG       = -400 -- prank challenge
Touch.ZORDER_LAYER_MAIL       = -400
Touch.ZORDER_LAYER_GM         = -400
Touch.ZORDER_LAYER_OPTION     = -400
Touch.ZORDER_LAYER_LOADRES    = -400	
Touch.ZORDER_LAYER_PRELOAD    = -400	
Touch.ZORDER_LAYER_LOGIN      = -400
Touch.ZORDER_LAYER_MAP        = -400
Touch.ZORDER_LAYER_LGUILD     = -400
Touch.ZORDER_LAYER_GUILD      = -400
Touch.ZORDER_LAYER_WELFARE    = -400
Touch.ZORDER_LAYER_LMEMBER    = -400
Touch.ZORDER_LAYER_LAPPLY     = -400
Touch.ZORDER_LAYER_LSTOCK     = -400
Touch.ZORDER_LAYER_INVEST     = -400
Touch.ZORDER_LAYER_LDEPOSIT   = -400
Touch.ZORDER_LAYER_NET        = -500
-- zorder end

-- register a onTouch callback handler for a layer
-- u may use callback=nil if there is no handler
-- touch
-- event: "began", "moved", "ended", "cancelled"
function Touch.layerRegister(layer, priority, callback, multi, swallow)
	if callback == nil then
		-- no need to register script handler and no need to set enable true
		return
	end
	local listener = cc.EventListenerTouchOneByOne:create()
	listener:setSwallowTouches(swallow)
	listener:registerScriptHandler(
		function(touch, event)
			local location = touch:getLocation()
			return callback('began', location.x, location.y)
		end, 
		cc.Handler.EVENT_TOUCH_BEGAN
	)
	listener:registerScriptHandler(
		function(touch, event)
			local location = touch:getLocation()
			return callback('moved', location.x, location.y)
		end, 
		cc.Handler.EVENT_TOUCH_MOVED
	)
	listener:registerScriptHandler(
		function(touch, event)
			local location = touch:getLocation()
			return callback('ended', location.x, location.y)
		end, 
		cc.Handler.EVENT_TOUCH_ENDED
	);
	--listener:registerScriptHandler(callback, cc.Handler.EVENT_TOUCH_BEGAN)
	--listener:registerScriptHandler(callback, cc.Handler.EVENT_TOUCH_MOVED)
	--listener:registerScriptHandler(callback, cc.Handler.EVENT_TOUCH_ENDED)
	local eventDispatcher = layer:getEventDispatcher()
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)
	--layer:setTouchMode(cc.TOUCHES_ALL_AT_ONCE)
	--layer:setTouchMode(cc.TOUCHES_ONE_BY_ONE)
end

-- @see in LuaEngine handleNodeEvent
--kCCNodeOnEnter: "enter"
--kCCNodeOnExit:  "exit";
--kCCNodeOnEnterTransitionDidFinish: "enterTransitionFinish"
--kCCNodeOnExitTransitionDidStart:   "exitTransitionStart"
--kCCNodeOnCleanup:                  "cleanup"
function Touch.nodeRegister(node, handler)
	if nil == node or nil == handler then
		return
	end
	node:registerScriptHandler(handler)
end

-- event: "backClicked", "menuClicked"
function Touch.keypadRegister(layer, handler)
	if nil == layer or nil == handler then
		return
	end
	--layer:setKeypadEnabled(true)
	layer:registerScriptKeypadHandler(handler)
end

-- include three function
--function util.layer_register(layer, priority, callback, multi, swallow)
--function util.node_register(node, handler)
--registerScriptKeypadHandler
-- all of them will unregister in destructor, no need to call them manually
function Touch.regHandler(layer, priority, handler, swallow, multi, no_keypad)
	multi = multi or false
	Touch.layerRegister(layer, priority, handler, multi, swallow)
	Touch.nodeRegister(layer, handler)
	if true == no_keypad then return end
	Touch.keypadRegister(layer, handler)
end

return Touch

