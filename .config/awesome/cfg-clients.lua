-- Syntaxic sugar
config.clients = {}

-- Clients requiring tiling
config.clients.tiling = {
	-- Gimp
	{rule = {class = "Gimp.*", instance = "gimp.*", role = "gimp-toolbox"},
		properties = {target = "master", split = 224}},
	{rule = {class = "Gimp.*", instance = "gimp.*", role = "gimp-image-window"},
		properties = {target = "slave",  split = 224}},
	{rule = {class = "Gimp.*", instance = "gimp.*"},
		properties = {target = "float",  split = 224}},
	-- Pidgin
	{rule = {class = "Pidgin", role = "buddy_list"},
		properties = {target = "master", split = 250}},
	{rule = {class = "Pidgin", role = "conversation"},
		properties = {target = "slave",  split = 250}},
	{rule = {class = "Pidgin"},
		properties = {target = "float",  split = 250}},
nil}

-- [AUTO-UPDATED] Hide statusbar for selected clients
config.clients.fullscreen = {
	{class = "Thelauncher", instance = "thelauncher"},
	{class = "URxvt", instance = "urxvt"},
	{class = "wesnoth", instance = "wesnoth"},
	{class = "Switchboard.py", instance = "switchboard.py"},
	{class = "VBoxSDL", instance = "VBoxSDL"},
	{class = "Claws-mail", instance = "claws-mail", role = "prefs_filtering"},
	{class = "XKeyCaps", instance = "xkeycaps"},
	{class = "Iceweasel", instance = "Browser", role = "Preferences"},
	{class = "Ufraw", instance = "ufraw"},
	{class = "Iceweasel", instance = "Places", role = "Organizer"},
	{class = "MPlayer", instance = "vaapi"},
	{class = "Frotz", instance = "frotz"},
	{class = "XKeyCaps", instance = "editKey"},
	{class = "Lprof", instance = "lprof"},
	{class = "Iceweasel", instance = "Extension", role = "Manager"},
nil}

-- Remapping keys
config.clients.keymap = {
	{rule = {class = "Scite"}, keys = {
		next = {"Control_L", "Next"},
		previous = {"Control_L", "Prior"}}},
	{rule = {class = "X-terminal-emulator"}, keys = {
		next = {"Control_L", "Next"},
		previous = {"Control_L", "Prior"}}},
nil}
