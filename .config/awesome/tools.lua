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

-- Syntaxic sugar for debugging
function dbg(text)
	naughty.notify{text = text, timeout = 0}
end

-- Print client information
function client_info(c)
	local t = "<b>Name</b>: " .. c.name
	t = t .. "\n<b>Class</b>: " .. c.class
	t = t .. "\n<b>Instance</b>: " .. c.instance
	t = t .. "\n<b>Role</b>: " .. (c.role or "nil")
	naughty.notify{icon = c.icon, icon_size = 32, text = t, timeout = 0}
end

-- Move tag right or left in the list
function tag_move(direction)
	local current_screen = mouse.screen
	local selected_tag = awful.tag.selected(current_screen)
	local screen_tags = screen[current_screen]:tags()
	if not selected_tag or #screen_tags < 2 then return end
	local position = nil
	for i, t in ipairs(screen_tags) do
		if t == selected_tag then position = i break end
	end
	local new_position = awful.util.cycle(#screen_tags, position + direction)
	local temp = screen_tags[position]
	screen_tags[position] = screen_tags[new_position]
	screen_tags[new_position] = temp
	screen[current_screen]:tags(screen_tags)
	awful.tag.viewonly(screen_tags[new_position])
end

-- Update section of file without touching the rest
function file_update(name, start, finish, contents)
	local file = io.open(name .. "-new", "w+")
	local mode = "start"
	for l in io.lines(name) do
		if mode == "start" then
			file:write(l .. "\n")
			if l:find(start, 1, true) then
				file:write(contents)
				mode = "skip"
			end
		elseif mode == "skip" then
			if l:find(finish, 1, true) then
				file:write(l .. "\n")
				mode = "close"
			end
		elseif mode == "close" then
			file:write(l .. "\n")
		end
	end
	file:close()
	os.remove(name)
	os.rename(name .. "-new", name)
end
