-- Hyprland configuration in Lua using the Hyprland Lua API
-- Monitor configuration

hl.monitor({
  output = "",
  mode = "preferred",
  position = "auto",
  scale = 1.0,
})

hl.monitor({
  output = "eDP-1",
  mode = "1920x1200@40",
  position = "auto",
  scale = 1.0,
})

-- Default applications

local terminal = "nixGL alacritty"
local fileManager = terminal .. " -e joshuto"
local menu = "wofi"
local browser = "zen-browser"

-- Autostart applications

hl.on("hyprland.start", function()
  hl.exec_cmd("fcitx5 -d")
  hl.exec_cmd("dunst")
  hl.exec_cmd("waybar")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("/usr/lib/gnome-keyring/daemon --start --components=pkcs11,secrets,ssh")
  hl.exec_cmd("nm-applet --indicator")
  hl.exec_cmd("hypridle")
  hl.exec_cmd("warp-taskbar")
  hl.exec_cmd("flameshot")
  hl.exec_cmd("xremap /home/toyama/.config/xremap/config.yml")
end)

-- Environment variables

hl.env("XCURSOR_SIZE", "16")
hl.env("HYPRCURSOR_SIZE", "16")

hl.env("QT_IM_MODULE", "fcitx")
hl.env("GTK_IM_MODULE", "")
hl.env("XMODIFIERS", "@im=fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "fcitx")
hl.env("QT_QPA_PLATFORM", "wayland")

-- Hyprland configuration

hl.config({
  general = {
    gaps_in = 1,
    gaps_out = 0,
    border_size = 1,
    col = {
      active_border = { colors = { "rgba(FFC107ee)", "rgba(FF5722ee)", }, angle = 45 },
      inactive_border = { colors = { "rgba(202020aa)" } },
    },
    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle",
  },
  decoration = {
    rounding = 8,
    rounding_power = 4,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = "rgba(262626ee)",
    },
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },
  animations = {
    enabled = true,
  },
  dwindle = {
    preserve_split = true,
  },
  master = {
    new_status = "master",
  },
  misc = {
    force_default_wallpaper = -1,
    disable_hyprland_logo = false,
  }
})

hl.layer_rule({
  name = "wofi blur",
  blur = true,
  match = {
    title = "wofi",
  }
})

-- Animations

hl.curve("easeOutQuint", {
  type = "bezier",
  points = {
    { 0.21, 1 }, { 0.32, 1 }
  }
})

hl.curve("easeInOutCubic", {
  type = "bezier",
  points = {
    { 0.65, 0.05 }, { 0.36, 1 }
  }
})

hl.curve("linear", {
  type = "bezier",
  points = {
    { 0, 0 }, { 1, 1 }
  }
})

hl.curve("almostLinear", {
  type = "bezier",
  points = {
    { 0.5, 0.5 }, { 0.75, 1 }
  }
})

hl.curve("quick", {
  type = "bezier",
  points = {
    { 0.15, 0 }, { 0.1, 1 }
  }
})

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5.00, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3.09, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.00, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Input configuration
-- Keyboard layout, mouse sensitivity, touchpad configuration, etc.

hl.config({
  input = {
    kb_layout = "jp",
    kb_variant = "",
    kb_model = "",
    kb_options = "",
    kb_rules = "",
    follow_mouse = 1,
    sensitivity = 0.3,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 0.4,
    },
  },
})

-- Gesture configuration

hl.config({
  gestures = {
    workspace_swipe_distance = 170,
    workspace_swipe_cancel_ratio = 0.1,
  }
})

hl.gesture({
  fingers = 4,
  direction = "horizontal",
  action = "workspace",
})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})


-- Keybindings

local mainMod = "ALT"

-- Applications launching

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind("CONTROL + SHIFT + ESCAPE", hl.dsp.exec_cmd(terminal .. " -e btop"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))

-- Brightness control
hl.bind(mainMod .. " + XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"))
hl.bind(mainMod .. " + XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set -5%"))
hl.bind(mainMod .. " + XF86TouchpadToggle", hl.dsp.exec_cmd("~/.config/hypr/switch_night_mode.sh"))

-- Volume control
hl.bind(mainMod .. " + XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 2"))
hl.bind(mainMod .. " + XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 2"))
hl.bind(mainMod .. " + XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))

-- Screenshot
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui"))

-- Window management
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))

hl.bind(mainMod .. " + F4", hl.dsp.window.close(hl.get_active_window()))

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen(hl.get_active_window()))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float(hl.get_active_window(), true))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + G", hl.dsp.layout("togglesplit"))

--- Workspace management
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mainMod .. " + CTRL +H", hl.dsp.focus({ workspace = "m-1" }))
hl.bind(mainMod .. " + CTRL +L", hl.dsp.focus({ workspace = "+1" }))

local special_workspaces = {
  minus = "discord",
  asciicircum = "notion",
  backslash = "music"
}

for k, v in pairs(special_workspaces) do
  hl.bind(mainMod .. " + " .. k, hl.dsp.workspace.toggle_special(v))
end

hl.window_rule({
  name = "Discord(-ptb)",
  match = {
    class = "^(discord|discord-ptb|Slack)$",
  },
  workspace = "special:discord silent",
})

hl.window_rule({
  name = "Notion",
  match = {
    class = "^(Notion)|^(notion-app-electron)$",
  },
  workspace = "special:notion silent",
})

hl.window_rule({
  name = "music",
  match = {
    class = "^(YouTube Music|Spotify)$",
  },
  workspace = "special:music silent",
})

-- Reload configuration
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))

-- System commands
hl.bind(mainMod .. " + X", hl.dsp.submap("system"))

hl.define_submap("system", function()
  hl.bind("L", hl.dsp.exec_cmd("hyprshutdown"))
  hl.bind("R", hl.dsp.exec_cmd("systemctl reboot"))
  hl.bind("U", hl.dsp.exec_cmd("systemctl poweroff"))
  hl.bind("RETURN", hl.dsp.submap("reset"))
  hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)
