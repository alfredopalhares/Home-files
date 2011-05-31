-- Global modules
require("awful")
require("beautiful")
require("naughty")
require("awful.startup_notification")

-- Local configuration
config = {}
-- Base directory
config.home = os.getenv("HOME") .. "/.config/awesome/"
-- Statusbar height
config.statusbar_height = 16
-- Tint of the selected tag, hex
config.tag_tint = "50"
-- Default floating windows gravity
config.gravity = {x = "center", y = "bottom"}

-- Custom theme
beautiful.init(config.home .. "cfg-theme.lua")
awful.startup_notification.cursor_waiting = "left_ptr"

-- Support functions
require("tools")
-- Key bindings
loadsafe("cfg-keys")
-- Clients requiring special treatment
loadsafe("cfg-clients")
-- Special layout for small screen
loadsafe("mod-smallscreen")
-- Floating statusbar
loadsafe("mod-statusbar")
-- Key mapper
loadsafe("mod-keymapper")

-- Global key bindings
root.keys(config.keys.global)

-- NEXT STEPS
-- wait for Gimp 2.8 release, test single window mode (everything else depends on this)
-- write Pidgin plugin for single window mode (possibility checked with developers)
-- get rid of tags management, all windows go to single tag
-- turn on composition to avoid redraws when switching windows
