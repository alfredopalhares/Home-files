local rules = require("awful.rules")

-- Widgets shared by all screens
local widgets = {statusbars = {}, taglists = {}}


--
-- Clock
--
widgets.clock_text = widget({type = "textbox"})
widgets.clock_icon = widget({type = "imagebox"})
widgets.clock_icon.image = image(config.home .. "icons/clock.png")
widgets.clock_tooltip = awful.tooltip({objects = {widgets.clock_text, widgets.clock_icon}})

local function update_clock()
	widgets.clock_text.text = " " .. tostring(tonumber(os.date("%k"))) .. os.date(":%M ")
	widgets.clock_tooltip:set_text(os.date("%A, %d %B %Y"))
end


--
-- Battery
--
widgets.battery_icons = {}
for i = 1, 5 do
	widgets.battery_icons[i] = image(config.home .. "icons/battery-" .. i .. ".png")
end
widgets.battery_text = widget({type = "textbox"})
widgets.battery_icon = widget({type = "imagebox"})
widgets.battery_tooltip = awful.tooltip({objects = {widgets.battery_text, widgets.battery_icon}})

-- Read one line from file
local function file_read(filename)
	local file = io.open(filename)
	local line = file:read()
	file:close()
	return line
end

-- Update battery status
local function update_battery()
	local cap, chg, cur = 0, 0, 0
	for i = 0, 2 do
		local basedir = "/sys/class/power_supply/BAT" .. tostring(i) .. "/"
		if awful.util.file_readable(basedir .. "charge_full") then
			cap = cap + tonumber(file_read(basedir .. "charge_full"))
			chg = chg + tonumber(file_read(basedir .. "charge_now"))
			cur = cur + tonumber(file_read(basedir .. "current_now"))
		end
	end
	local state = ""
	local tooltip = "<b>Battery state</b>: Charging\n"
	if tonumber(file_read("/sys/class/power_supply/AC/online")) == 0 then
		local level = chg/cur
		local minutes = tostring(math.floor((level - math.floor(level))*60))
		if #minutes == 1 then
			minutes = "0" .. minutes
		end
		state = tostring(math.floor(level)) .. ":" .. minutes
		local tooltip = "<b>Battery state</b>: Disharging\n"
	else
		state = tostring(math.floor(100*chg/cap)) .. "%"
	end
	widgets.battery_text.text = " " .. state .. "  "
	widgets.battery_tooltip:set_text(tooltip .. "<b>Battery level</b>: " .. tostring(math.floor(100*chg/cap)) .. "%")
	local i = 1.5 + (chg/cap*#widgets.battery_icons*(#widgets.battery_icons - 2) + 0.5)/(#widgets.battery_icons - 1)
	widgets.battery_icon.image = widgets.battery_icons[math.floor(i)]
end


--
-- Separator
--
widgets.separator = widget({type = "textbox"})
widgets.separator.text = "<span foreground=\"" .. beautiful.fg_inactive .. "\"> | </span>"


--
-- Statusbar
--

-- Timer
local statusbar_timer = timer({})

-- Set statusbar width and position
local function update_geometry(screen, tag)
	local index = screen.index
	local width = 0
	for k, widget in pairs(widgets.statusbars[index].widgets) do
		if widget == widgets.taglists[index] then
			width = width + #screen:tags()*widgets.statusbars[index]:geometry().height
		elseif k ~= "layout" then
			width = width + widget:extents().width
		end
	end
	widgets.statusbars[index]:geometry({x = screen.geometry.width - width, width = width})
end

-- Timed statusbar updates
local function update_statusbar()
	if statusbar_timer.started then
		statusbar_timer:stop()
	end
	update_clock()
	update_battery()
	for s = 1, screen.count() do
		update_geometry(screen[s])
	end
	statusbar_timer.timeout = 60 - tonumber(os.date("%S"))
	statusbar_timer:start()
end

-- Update on dbus events
dbus.add_match("system", "type='signal',interface='org.freedesktop.Hal.Device',member='PropertyModified',path='/org/freedesktop/Hal/devices/computer_power_supply_ac_adapter_AC'")
dbus.add_signal("org.freedesktop.Hal.Device", update_statusbar)
dbus.add_match("system", "type='signal',interface='org.freedesktop.ConsoleKit.Session',member='ActiveChanged'")
dbus.add_signal("org.freedesktop.ConsoleKit.Session", update_statusbar)

-- Initial setup
for s = 1, screen.count() do
	widgets.taglists[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, config.keys.taglist)
	local statusbar = wibox({})
	statusbar.ontop = true
	statusbar.screen = s
	statusbar:geometry({x = 900, y = 5, width = 124, height = config.statusbar_height})
	statusbar.widgets = {widgets.taglists[s],
			     widgets.separator,
			     widgets.battery_icon,
			     widgets.battery_text,
			     widgets.clock_icon,
			     widgets.clock_text,
			     layout = awful.widget.layout.horizontal.leftright}
	widgets.statusbars[s] = statusbar
	screen[s]:add_signal("tag::attach", update_geometry)
	screen[s]:add_signal("tag::detach", update_geometry)
end
statusbar_timer:add_signal("timeout", update_statusbar)
update_statusbar()


--
-- Hide statusbar for selected clients
--

-- Find client in client_state table
local function find_client(c)
	for k, r in pairs(config.clients.fullscreen) do
		if rules.match(c, r) then
			return k
		end
	end
	return nil
end

-- Change treatment of current window and save to disk
function statusbar_toggle(c)
	-- Update rules list
	local k = find_client(c)
	if k then
		table.remove(config.clients.fullscreen, k)
		widgets.statusbars[c.screen].ontop = true
	else
		config.clients.fullscreen[#config.clients.fullscreen + 1] = {class = c.class, instance = c.instance, role = c.role}
		widgets.statusbars[c.screen].ontop = false
	end
	-- Write rules to disk
	local rules = ""
	for _, r in pairs(config.clients.fullscreen) do
		rules = rules .. "\t{class = \"" .. r.class .. "\", instance = \"" .. r.instance
		if r.role then
			rules = rules .. "\", role = \"" .. r.role
		end
		rules = rules .. "\"},\n"
	end
	file_update(config.home .. "cfg-clients.lua", "config.clients.fullscreen", "nil}", rules)
end

-- Show or hide statusbar when current window changes
local function statusbar_visibility(c)
	if find_client(c) then
		widgets.statusbars[c.screen].ontop = false
	else
		widgets.statusbars[c.screen].ontop = true
	end
end
client.add_signal("focus", statusbar_visibility)
