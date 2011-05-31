-- Some syntaxic sugar
config.keys = {}

-- Core modifier key
Mod = "Mod1"

-- Global keys
config.keys.global = awful.util.table.join(
	awful.key({              }, "XF86AudioRaiseVolume", awful.tag.viewnext),
	awful.key({              }, "XF86AudioLowerVolume", awful.tag.viewprev),
	awful.key({Mod, "Control"}, "XF86AudioRaiseVolume", function() tag_move(1) end),
	awful.key({Mod, "Control"}, "XF86AudioLowerVolume", function() tag_move(-1) end),
	awful.key({Mod, "Control"}, "r",                    awesome.restart),
	awful.key({Mod, "Control"}, "q",                    awesome.quit),
	awful.key({Mod,          }, "Prior",                function() awful.util.spawn("thelauncher") end),
	awful.key({Mod,          }, "Next",                 function() awful.util.spawn("x-terminal-emulator") end),
nil)

-- Client windows
config.keys.client = awful.util.table.join(
	awful.key({Mod           }, "BackSpace",            function(c) c:kill() end),
	--awful.key({Mod, "Control"}, "BackSpace",            function(c) c:kill() end),
	awful.key({Mod, "Control"}, "t",                    function(c) test() end),
	awful.key({Mod, "Control"}, "f",                    function(c) floating_toggle(c) end),
	awful.key({Mod, "Control"}, "i",                    function(c) client_info(c) end),
	awful.key({Mod, "Control"}, "Return",               function(c) statusbar_toggle(c) end),
	awful.key({Mod, "Control"}, "Up",                   function(c) floating_position(c, nil, "center", "center") end),
	awful.key({Mod, "Control"}, "Left",                 function(c) floating_position(c, nil, "left", "bottom") end),
	awful.key({Mod, "Control"}, "Down",                 function(c) floating_position(c, nil, "center", "bottom") end),
	awful.key({Mod, "Control"}, "Right",                function(c) floating_position(c, nil, "right", "bottom") end),
	awful.key({     "Control"}, "XF86AudioRaiseVolume", function(c) key_press(c, "next") end),
	awful.key({     "Control"}, "XF86AudioLowerVolume", function(c) key_press(c, "previous") end),
nil)

-- Floating windows
config.keys.float = awful.util.table.join(
	awful.button({   }, 1, function(c) client.focus = c; c:raise() end),
	awful.button({Mod}, 1, function(c) floating_move(c) end),
	awful.button({Mod}, 3, awful.mouse.client.resize),
nil)

-- Window list
config.keys.taglist = awful.util.table.join(
	awful.button({   }, 1, awful.tag.viewonly),
nil)
