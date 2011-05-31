require("awful.autofocus")
local rules = require("awful.rules")

-- Configure window depending on floating state
local function window_configure(c)
	-- Settings for floating windows
	if awful.client.floating.get(c) then
		c.size_hints_honor = true
		c.border_width = 2
		c.border_color = beautiful.border_normal
		c.above = true
		floating_position(c, nil, config.gravity.x, config.gravity.y)
	-- Settings for all other windows
	else
		c.size_hints_honor = false
		c.border_width = 0
	end
end

-- Create and configure new tag
local function tag_create(c)
	tag = awful.tag.new({""}, c.screen, awful.layout.suit.max)
	awful.tag.seticon(c.icon or beautiful.icon, tag[1])
	awful.tag.setproperty(tag[1], "icon_only", 1)
	awful.tag.viewonly(tag[1])
	return tag
end

-- Do not allow to move or resize fixed windows, reposition floating window when size changes
local function window_keep(c)
	if awful.client.floating.get(c) then
		local pos = awful.client.property.get(c, "gravity")
		if pos then
			floating_position(c, nil, pos.x, pos.y)
		end
	else
		if awful.client.property.get(c, "tiling") then return end
		local cg = c:geometry()
		local sg = screen[c.screen].geometry
		if cg.x ~= 0 or cg.y ~= 0 then
			c:geometry({x = 0, y = 0})
		end
		if cg.width ~= sg.width or cg.height ~= sg.height then
			c:geometry({width = sg.width, height = sg.height})
		end
	end
end

-- Update tag icon when window icon updates
local function window_icon(c)
	if awful.client.floating.get(c) then return end
	if awful.client.property.get(c, "tiling") == "slave" then return end
	for _, t in pairs(c:tags()) do
		awful.tag.seticon(c.icon, t)
	end
end

-- List tag clients excluding floaters and given window
function tag_clients(tag, client)
	local list = {}
	for k, c in pairs(tag:clients()) do
		if c~= client and not awful.client.floating.get(c) then
			list[k] = c
		end
	end
	return list
end

-- Tag focus history
local tag_history = {}
local function tag_history_delete(tag)
	for k, t in pairs(tag_history) do
		if t == tag or not t.screen then
			table.remove(tag_history, k)
		end
	end
end
local function tag_history_update(tag)
	if tag.selected then
		tag_history_delete(tag)
		tag_history[#tag_history + 1] = tag
	end
end
for s = 1, screen.count() do
	awful.tag.attached_add_signal(s, "property::selected", tag_history_update)
	screen[s]:add_signal("tag::detach", tag_history_delete)
end

-- Add color tint on top of selected tags
function tag_icon(tag)
	local icons = awful.tag.getproperty(tag, "icons")
	if not icons then
		local i = awful.tag.geticon(tag)
		local size = config.statusbar_height
		if not i then return end
		local ni = i:crop_and_scale(0, 0, i.width, i.height, size, size)
		local si = i:crop_and_scale(0, 0, i.width, i.height, size, size)
		si:draw_rectangle(0, 0, size, size, true, beautiful.bg_focus .. config.tag_tint)
		icons = {normal = ni, selected = si}
		awful.tag.setproperty(tag, "icons", icons)
	end
	if tag.selected then
		awful.tag.seticon(icons.selected, tag)
	else
		awful.tag.seticon(icons.normal, tag)
	end
end
for s = 1, screen.count() do
	awful.tag.attached_add_signal(s, "property::selected", tag_icon)
end

-- Destroy empty tags when windows are moved or closed
local function tags_empty()
	for s = 1, screen.count() do
		local tags = screen[s]:tags()
		for i, t in ipairs(tags) do
			local destroy = true
			for _, c in pairs(t:clients()) do
				if #c:tags() == 1 then
					destroy = false
					break
				end
			end
			if destroy then
				if awful.tag.selected(s) == t then
					local ttag = nil
					if #tag_history > 0 then
						ttag = tag_history[#tag_history - 1]
					end
					if #tags > 1 then
						if not ttag then
							ttag = tags[awful.util.cycle(#tags, i - 1)]
						end
						awful.tag.viewonly(ttag)
					else
						awful.tag.viewnone(s)
					end
				end
				t.screen = nil
			end
		end
	end
end
client.add_signal("unmanage", tags_empty)

-- Position floating window
function floating_position(c, parent, xpos, ypos)
	if not awful.client.floating.get(c) then return end
	awful.client.property.set(c, "gravity", {x = xpos, y = ypos})
	local cg = c:geometry()
	local sg = screen[c.screen].geometry
	if parent then
		local sg = parent:geometry()
	end
	local dw = sg.width - cg.width
	local dh = sg.height - cg.height
	local position = {x = sg.x + dw/2, y = sg.y + dh/2}
	if xpos == "left" then
		position.x = 0
	elseif xpos == "right" then
		position.x = sg.x + dw
	end
	if ypos == "top" then
		position.y = 0
	elseif ypos == "bottom" then
		position.y = sg.y + dh
	end
	c:geometry(position)
end

-- Reset gravity when window is moved
function floating_move(c)
	awful.client.property.set(c, "gravity", nil)
	awful.mouse.client.move(c)
end

-- Take care of new windows
client.add_signal("manage", function(c, startup)
	-- Decide if client goes to current screen
	if not startup and awful.client.focus.filter(c) then
		c.screen = mouse.screen
	end
	-- Check if client is tiling
	local tiling = nil
	for _, r in pairs(config.clients.tiling) do
		if rules.match(c, r.rule) then
			tiling = r.properties
			break
		end
	end
	-- Configure tiling clients
	if tiling then
		awful.client.property.set(c, "tiling", tiling.target)
		if tiling.target == "master" then
			awful.client.floating.set(c, false)
		elseif tiling.target == "slave" then
			awful.client.floating.set(c, false)
			awful.client.setslave(c)
		elseif tiling.target == "float" then
			awful.client.floating.set(c, true)
		end
	end
	-- No sticky windows allowed
	c.sticky = false
	-- Big windows do not float
	if awful.client.floating.get(c) then
		local cg = c:geometry()
		local sg = screen[c.screen].geometry
		if cg.width > 0.8*sg.width and cg.height > 0.8*sg.height then
			awful.client.floating.set(c, false)
			if tiling then
				tiling.target = "slave"
				awful.client.setslave(c)
			end
		end
	end
	-- Find existing tag(s) for floaters
	local tags = {}
	if awful.client.floating.get(c) then
		-- Copy tag(s) from parent for transients
		if c.transient_for then
			c.screen = c.transient_for.screen
			tags = c.transient_for:tags()
		-- Try to find tag(s) by class for non-transient floater
		else
			for _, t in pairs(awful.tag.selectedlist(c.screen)) do
				local tc = tag_clients(t, c)
				if #tc > 0 and tc[1].class == c.class then
					tags[#tags + 1] = t
				end
			end
		end
		-- Become sticky if previous attempts failed
		if #tags == 0 and not tiling then
			c.sticky = true
			tags = screen[c.screen]:tags()
		end
	end
	-- Try to find existing tag for tilings
	local master = nil
	if #tags == 0 and tiling then
		for _, w in pairs(client.get()) do
			if w.class == c.class and w ~= c then
				-- Floaters go to all found tags
				if tiling.target == "float" then
					c.screen = w.screen
					for _, t in pairs(w:tags()) do
						if not awful.util.table.hasitem(tags, t) then
							tags[#tags + 1] = t
						end
					end
				-- Masters can go to lonely slave(s) only
				elseif tiling.target == "master" then
					if awful.client.property.get(w, "tiling") == "slave" then
						local t = w:tags()
						if #t == 1 and #tag_clients(t[1], c) == 1 then
							tags = awful.util.table.join(tags, t)
						end
					end
				-- Slaves connect to first available master
				elseif tiling.target == "slave" then
					if awful.client.property.get(w, "tiling") == "master" then
						local t = w:tags()
						if #t == 1 and #tag_clients(t[1], c) == 1 then
							tags = t
						else
							master = w
						end
						break
					end
				end
			end
		end
	end
	-- Create tag if none were not found
	if #tags == 0 then
		tags = tag_create(c)
		if tiling then
			awful.tag.setproperty(tags[1], "layout", awful.layout.suit.tile)
			awful.tag.setmwfact(tiling.split/screen[c.screen].geometry.width, tags[1])
		end
	end
	-- Attach clients to tags
	if master then
		master:tags(awful.util.table.join(master:tags(), tags))
	end
	c:tags(tags)
	-- Common settings for all windows
	c:keys(config.keys.client)
	c:buttons(config.keys.float)
	window_configure(c)
	c:add_signal("property::geometry", window_keep)
	c:add_signal("property::icon", window_icon)
	-- Do not focus if transient is on non-visible tag
	if awful.client.floating.get(c) then
		local stags = awful.tag.selectedlist(c.screen)
		for _, t in pairs(tags) do
			if awful.util.table.hasitem(stags, t) then
				client.focus = c
				break
			end
		end
	else
		client.focus = c
	end
end)

-- Toggle window floating state
function floating_toggle(c)
	-- Ground the floater
	if awful.client.floating.get(c) then
		awful.client.floating.set(c, false)
		window_configure(c)
		local tag = nil
		local master = nil
		if awful.client.property.get(c, "tiling") then
			for _, w in pairs(client.get()) do
				if awful.client.property.get(w, "tiling") == "master" then
					local t = w:tags()
					if #t == 1 and #tag_clients(t[1], c) == 1 then
						tags = t
					else
						master = w
					end
					break
				end
			end
		end
		if #tag == 0 then
			tag = tag_create(c)
		end
		c:tags(tag)
		if master then
			master:tags(awful.util.table.join(master:tags(), tag))
		end
	-- Float the window
	else
		if awful.client.property.get(c, "tiling") == "master" then return end
		awful.client.floating.set(c, true)
		local sg = screen[c.screen].geometry
		c:geometry({width = 0.5*sg.width, height = 0.5*sg.height})
		window_configure(c)
		c.sticky = true
		c:tags(screen[c.screen]:tags())
	end
	-- Destroy tags if needed
	tags_empty()
end

-- Propagate sticky windows to new tags
for s = 1, screen.count() do
	screen[s]:add_signal("tag::attach", function(s, tag)
		for _, c in pairs(client.get()) do
			if c.screen == s and c.sticky then
				c:tags(awful.util.table.join(c:tags(), {tag}))
			end
		end
	end)
end
