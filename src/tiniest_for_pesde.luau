-- From dphfox/tiniest, licensed under BSD3
--!strict

local lua_env: any = (_G :: any).LUA_ENV

if lua_env == "roblox" then
	return require("./tiniest_for_roblox")
elseif lua_env == "lune" then
	return require("./tiniest_for_lune")
else
	return require("./tiniest")
end
