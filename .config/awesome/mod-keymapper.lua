local rules = require("awful.rules")

-- Send mapped keys to the client
function key_press(c, key)
	local keys = nil
	for _, r in pairs(config.clients.keymap) do
		if rules.match(c, r.rule) then
			keys = r.keys[key]
			break
		end
	end
	if not keys then return end
	local press_timer = timer({timeout = 0.3})
	press_timer:add_signal("timeout", function()
		press_timer:stop()
		for i = 1, #keys do
			root.fake_input("key_press", keys[i])
		end
		for i = #keys, 1, -1 do
			root.fake_input("key_release", keys[i])
		end
	end)
	press_timer:start()
end

-- Convert config.clients.keymap from keysyms to keycodes
load_timer = timer({timeout = 2})
load_timer:add_signal("timeout", function()
	load_timer:stop()
	-- Load mapping table
	local map = {}
	for line in io.popen("xmodmap -pk", "r"):lines() do
		if line:find("0x", 1, true) then
			code, symbol = line:match("^%s*(%d*)%s*0x%x*%s*%(([_%w]*)")
			map[symbol] = tonumber(code)
		end
	end
	-- Map keysyms to keycodes
	for kc, client in pairs(config.clients.keymap) do
		for km, keymap in pairs(client.keys) do
			for kk, key in pairs(keymap) do
				config.clients.keymap[kc].keys[km][kk] = map[key]
			end
		end
	end
end)
load_timer:start()
