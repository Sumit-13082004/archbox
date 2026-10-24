local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.automatically_reload_config = true
config.enable_tab_bar = false
config.window_close_confirmation = "NeverPrompt"
config.window_decorations = "RESIZE" -- no title bar, keep the resizable border
config.default_cursor_style = "BlinkingBar"
config.color_scheme = "Nord (Gogh)"
config.font = wezterm.font("JetBrains Mono", { weight = "Bold" })
config.font_size = 12.5

-- Background image is a local file, not tracked in this repo.
-- Point this at your own image, or delete this layer entirely.
config.background = {
  {
    source = {
      File = "/home/sumit/Downloads/bg-console.png",
    },
    hsb = {
      hue = 1.0,
      saturation = 1.02,
      brightness = 0.25,
    },
    width = "100%",
    height = "100%",
  },
  {
    source = {
      Color = "#282c35",
    },
    width = "100%",
    height = "100%",
    opacity = 0.55,
  },
}

config.window_padding = {
  left = 3,
  right = 3,
  top = 0,
  bottom = 30,
}

return config
