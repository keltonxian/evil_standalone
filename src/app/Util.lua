
local Util = class("Util")

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

return Util
