local Util = require("app.base.Util")
local Scene = require("app.base.Scene")

local Net = class("Net")

local g_instance = nil

local function Instance()
	if nil == g_instance then
		g_instance = Net:create()
	end
	return g_instance
end

function Net:ctor(...)
	self._serverList = nil
end

function Net:setServerList(list)
	self._server_list = list
end

function Net:loadServer()
	-- server_list see in version.lua
	local list = {}
	for i = 1, #(self._server_list or {}) do
		local info = self._server_list[i]
		local flag = tonumber(info.flag)
		if flag > 0 or true == Util.DEBUG_MODE then
			table.insert(list, info)
		end
	end
	return list
end

function Net:getServerName(list, ip)
	list = list or {}
	for i = 1, #list do
		local info = list[i]
		local ipaddr = info.ip
		--print('ipaddr, ip: ', ipaddr, ip)
		if ipaddr == ip then
			local name = info.name
			local state = info.state
			local str = string.format("%s [ %s ]", name, state)
			return str
		end
	end
	return Util.lText("UNKNOW_SERVER")
end

function Net:netSend(cmd, no_loading)
	if true ~= Scene:isOnline() then
		return
	end
	if true ~= no_loading then
		show_netloading()
	end
	Util.log("net_send[%s]", cmd)
	local str = '发送[' .. cmd .. ']'
	add_chat_msg(C_LOG, 0, '日志', str, get_time())
	local ret
	ret = LayerSocket:sendCmd(cmd .. '\n')
	return ret
end

function Net:showErr(input_list, err)
	Scene:hideNetLoading()
	local layer = require("app.layer.pop.LayerMsg"):create(err)
	Scene:addLayer(Touch.ZORDER_LAYER_MSG, layer)
end

return Instance()

