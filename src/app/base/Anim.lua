
local Anim = class("Anim")

-- scale back and fade in
function Anim.keffShowUp1(node, delay, time, original_scale)
	if nil == node then return end
	local action_tag = 91
	time = time or 0.2
	node:setOpacity(0)
	node:stopActionByTag(action_tag)
	local scale = original_scale or node:getScale()
	node:setScale(scale*1.2)
	local array = {}
	local sa = {}
	delay = delay or 0
	table.insert(array, cc.DelayTime:create(delay))
	table.insert(sa, cc.FadeIn:create(time))
	table.insert(sa, cc.ScaleTo:create(time, scale))
	table.insert(array, cc.Spawn:create(sa))
	local action = cc.Sequence:create(array)
	action:setTag(action_tag)
	node:runAction(action)
	local list = node:getChildren()
	for i = 1, #list do
		local s = list[i]
		s:stopActionByTag(action_tag)
		s:setOpacity(0)
		local alist = {}
		delay = delay or 0
		table.insert(alist, cc.DelayTime:create(delay))
		table.insert(alist, cc.FadeIn:create(time))
		local a = cc.Sequence:create(alist)
		a:setTag(action_tag)
		s:runAction(a)
	end
end

function Anim.stopKeffShowUp1(node, original_scale)
	if nil == node then return end
	local action_tag = 91
	node:setOpacity(0)
	node:stopActionByTag(action_tag)
	local scale = original_scale or node:getScale()
	node:setScale(scale*1.2)
	local list = node:getChildren()
	for i = 1, #list do
		local s = list[i]
		s:stopActionByTag(action_tag)
		s:setOpacity(0)
	end
end

return Anin

