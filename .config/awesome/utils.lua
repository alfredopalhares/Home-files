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

-- Volume control function by percentage
function volume (mode, vol)
	if mode == "up" and vol < 99 then
		vol = vol + 2
	elseif mode == "down" and vol > 1 then
		vol = vol - 2
	end
	io.popen("amixer sset 'Master Front' "..vol.."%"):read("*all")
end
