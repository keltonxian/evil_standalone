
local Bit = class("Bit")

local bit = nil

function Bit.getBit()
	if nil ~= bit then
		return bit
	end
	bit = { data32 = {} }
	for i = 1, 32 do
		bit.data32[i] = 2 ^ (32 - i)
	end
	return bit
end

function Bit.d2b(arg)
	local bit = Bit.getBit()
	local tr = {}
	for i = 1, 32 do
		if arg >= bit.data32[i] then
			tr[i] = 1
			arg = arg - bit.data32[i]
		else
			tr[i] = 0
		end
	end
	return tr
end

function Bit.b2d(arg)
	local nr = 0
	for i = 1, 32 do
		if arg[i] == 1 then
			nr = nr + 2 ^ (32 - i)
		end
	end
	return nr
end

function Bit.bitAnd(a, b)
	local op1 = Bit.d2b(a)
	local op2 = Bit.d2b(b)
	local r = {}
	for i = 1, 32 do
		if op1[i] == 1 and op2[i] == 1 then
			r[i] = 1
		else
			r[i] = 0
		end
	end
	return Bit.b2d(r)
end

function Bit.bitOr(a, b)
	local op1 = Bit.d2b(a)
	local op2 = Bit.d2b(b)
	local r = {}
	for i = 1, 32 do
		if op1[i] == 1 or op2[i] == 1 then
			r[i] = 1
		else
			r[i] = 0
		end
	end
	return Bit.b2d(r)
end

function Bit.bitLshift(a, n)
	local op1 = Bit.d2b(a)
	local r = Bit.d2b(0)
	if n < 32 and n > 0 then
		for i = 1, n do
			for j = 1, 31 do
				op1[j] = op1[j + 1]
			end
			op1[32] = 0
		end
		r = op1
	end
	return Bit.b2d(r)
end

function Bit.bitRshift(a, n)
	local op1 = Bit.d2b(a)
	local r = Bit.d2b(0)
	if n < 32 and n > 0 then
		for i = 1, n do
			for j = 31, 1, -1 do
				op1[j + 1] = op1[j]
			end
			op1[1] = 0
		end
	r = op1
	end
	return Bit.b2d(r)
end

function Bit.bitNot(a)
	local op1 = Bit.d2b(a)
	local r = {}
	for i = 1, 32 do
		if op1[i] == 1 then
			r[i] = 0
		else
			r[i] = 1
		end
	end
	return Bit.b2d(r)
end

function Bit.bitXor(a, b)
	local op1 = Bit.d2b(a)
	local op2 = Bit.d2b(b)
	local r = {}
	for i = 1, 32 do
		if op1[i] == op2[i] then
			r[i] = 0
		else
			r[i] = 1
		end
	end
	return Bit.b2d(r)
end

return Bit

