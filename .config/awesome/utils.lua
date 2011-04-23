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
