-- Clients array
config.clients = {}


config.clients.tilling = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     buttons = clientbuttons } },
	-- Gimp
	{rule = {class = "Gimp.*", instance = "gimp.*", role = "gimp-toolbox"},
		properties = {target = "master", split = 224}},
	{rule = {class = "Gimp.*", instance = "gimp.*", role = "gimp-image-window"},
		properties = {target = "slave",  split = 224}},
	{rule = {class = "Gimp.*", instance = "gimp.*"},
		properties = {target = "float",  split = 224}},
      properties = { floating = true } },
    { rule = { class = "gimp" },
    -- Set Firefox to always map on tags number 2 of screen 1.
    { rule = { class = "Firefox" },
      properties = { tag = tags[1][2] } }
}


config.clients.floating = {
	-- MPlayer as floating
    { rule = { class = "MPlayer" },
      properties = { floating = true } }
}

-- TODO: Code to open firefox in one tag, NOT TESTED !
-- tag.add_signal("property::selected", function (t) if t.name == "www" then ... end)
