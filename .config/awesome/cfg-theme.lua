theme = {}

theme.font          = "Series 60 Sans 8"

theme.bg_normal     = "#5C5C5C"
theme.bg_focus      = "#B08352"
theme.bg_urgent                            = "#ff0000"
theme.bg_minimize   = theme.bg_normal

theme.fg_normal     = "#CACACA"
theme.fg_inactive   = "#808080"
theme.fg_focus      = "#000000"
theme.fg_urgent     = theme.fg_normal
theme.fg_minimize   = theme.fg_normal

theme.border_width  = 0
theme.border_normal = theme.bg_focus
theme.border_focus  = theme.bg_focus
theme.border_marked = theme.bg_focus

theme.icon          = image(config.home .. "icons/default.png")

return theme
