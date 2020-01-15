
cc.FileUtils:getInstance():setPopupNotify(false)

require "config"
require "cocos.init"

function kdebug(...)
	printLog("DBEUG", ...)
end

function kerror(...)
	printLog("ERROR", ...)
end

local function main()
    math.randomseed(os.time())
    --require("app.MyApp"):create():run()
    require("version"):create():run()
end

local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    print(msg)
end
