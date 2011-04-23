-- Load file in failsafe mode
function loadsafe(name)
	success, result = pcall(function() return dofile(config.home .. name .. ".lua") end)
	if success then
		return result
	else
		print(result)
		return nil
	end
end

-- For easy debugging, text needs to be a string
function dbg(text)
	naughty.notify{text = text, timeout = 0}
end

-- Volume control function by percentage
function volume (mode)
	if mode == "up" and config.volume < 99 then
		config.volume = config.volume + 2
	elseif mode == "down" and config.volume > 1 then
		config.volume = config.volume - 2
	end
	io.popen("amixer sset 'Master Front' "..vol.."%"):read("*all")
end
