local wezterm = require 'wezterm'

local colors = {
  latte = {
    rosewater = "#dc8a78",
    flamingo = "#dd7878",
    pink = "#ea76cb",
    mauve = "#8839ef",
    red = "#d20f39",
    maroon = "#e64553",
    peach = "#fe640b",
    yellow = "#df8e1d",
    green = "#40a02b",
    teal = "#179299",
    sky = "#04a5e5",
    sapphire = "#209fb5",
    blue = "#1e66f5",
    lavender = "#7287fd",
    text = "#4c4f69",
    subtext1 = "#5c5f77",
    subtext0 = "#6c6f85",
    overlay2 = "#7c7f93",
    overlay1 = "#8c8fa1",
    overlay0 = "#9ca0b0",
    surface2 = "#acb0be",
    surface1 = "#bcc0cc",
    surface0 = "#ccd0da",
    crust = "#dce0e8",
    mantle = "#e6e9ef",
    base = "#eff1f5",
  },
  frappe = {
    rosewater = "#f2d5cf",
    flamingo = "#eebebe",
    pink = "#f4b8e4",
    mauve = "#ca9ee6",
    red = "#e78284",
    maroon = "#ea999c",
    peach = "#ef9f76",
    yellow = "#e5c890",
    green = "#a6d189",
    teal = "#81c8be",
    sky = "#99d1db",
    sapphire = "#85c1dc",
    blue = "#8caaee",
    lavender = "#babbf1",
    text = "#c6d0f5",
    subtext1 = "#b5bfe2",
    subtext0 = "#a5adce",
    overlay2 = "#949cbb",
    overlay1 = "#838ba7",
    overlay0 = "#737994",
    surface2 = "#626880",
    surface1 = "#51576d",
    surface0 = "#414559",
    base = "#303446",
    mantle = "#292c3c",
    crust = "#232634",
  },
  macchiato = {
    rosewater = "#f4dbd6",
    flamingo = "#f0c6c6",
    pink = "#f5bde6",
    mauve = "#c6a0f6",
    red = "#ed8796",
    maroon = "#ee99a0",
    peach = "#f5a97f",
    yellow = "#eed49f",
    green = "#a6da95",
    teal = "#8bd5ca",
    sky = "#91d7e3",
    sapphire = "#7dc4e4",
    blue = "#8aadf4",
    lavender = "#b7bdf8",
    text = "#cad3f5",
    subtext1 = "#b8c0e0",
    subtext0 = "#a5adcb",
    overlay2 = "#939ab7",
    overlay1 = "#8087a2",
    overlay0 = "#6e738d",
    surface2 = "#5b6078",
    surface1 = "#494d64",
    surface0 = "#363a4f",
    base = "#24273a",
    mantle = "#1e2030",
    crust = "#181926",
  },
  mocha = {
    rosewater = "#f5e0dc",
    flamingo = "#f2cdcd",
    pink = "#f5c2e7",
    mauve = "#cba6f7",
    red = "#f38ba8",
    maroon = "#eba0ac",
    peach = "#fab387",
    yellow = "#f9e2af",
    green = "#a6e3a1",
    teal = "#94e2d5",
    sky = "#89dceb",
    sapphire = "#74c7ec",
    blue = "#89b4fa",
    lavender = "#b4befe",
    text = "#cdd6f4",
    subtext1 = "#bac2de",
    subtext0 = "#a6adc8",
    overlay2 = "#9399b2",
    overlay1 = "#7f849c",
    overlay0 = "#6c7086",
    surface2 = "#585b70",
    surface1 = "#45475a",
    surface0 = "#313244",
    base = "#1e1e2e",
    mantle = "#181825",
    crust = "#11111b",
  },
}



local function is_vi_process(pane)
  return pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function conditional_activate_pane(window, pane, pane_direction, vim_direction)
  if is_vi_process(pane) then
    window:perform_action(wezterm.action.SendKey({ key = vim_direction, mods = "ALT" }), pane)
  else
    window:perform_action(wezterm.action.ActivatePaneDirection(pane_direction), pane)
  end
end

wezterm.on("ActivatePaneDirection-right", function(window, pane)
  conditional_activate_pane(window, pane, "Right", "l")
end)
wezterm.on("ActivatePaneDirection-left", function(window, pane)
  conditional_activate_pane(window, pane, "Left", "h")
end)
wezterm.on("ActivatePaneDirection-up", function(window, pane)
  conditional_activate_pane(window, pane, "Up", "k")
end)
wezterm.on("ActivatePaneDirection-down", function(window, pane)
  conditional_activate_pane(window, pane, "Down", "j")
end)

local function get_process(tab)
  local process_icons = {
    ["docker"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["docker-compose"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["nvim"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.custom_vim },
    },
    ["vim"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.dev_vim },
    },
    ["node"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.mdi_hexagon },
    },
    ["zsh"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_terminal },
    },
    ["bash"] = {
      { Foreground = { Color = colors.subtext0 } },
      { Text = wezterm.nerdfonts.cod_terminal_bash },
    },
    ["paru"] = {
      { Foreground = { Color = colors.lavender } },
      { Text = wezterm.nerdfonts.linux_archlinux },
    },
    ["htop"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
    },
    ["cargo"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_rust },
    },
    ["go"] = {
      { Foreground = { Color = colors.sapphire } },
      { Text = wezterm.nerdfonts.mdi_language_go },
    },
    ["lazydocker"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["git"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_git },
    },
    ["lazygit"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_git },
    },
    ["lua"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.seti_lua },
    },
    ["wget"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_arrow_down_box },
    },
    ["curl"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_flattr },
    },
    ["gh"] = {
      { Foreground = { Color = colors.mauve } },
      { Text = wezterm.nerdfonts.dev_github_badge },
    },
  }

  local process_name = string.gsub(tab.active_pane.foreground_process_name, "(.*[/\\])(.*)", "%2")

  return wezterm.format(
    process_icons[process_name] or
    { { Foreground = { Color = colors.sky } }, { Text = string.format("[%s]", process_name) } }
  )
end

local function get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir
  local HOME_DIR = string.format("file://%s", os.getenv("HOME"))

  return current_dir == HOME_DIR and "  ~" or string.format("  %s", string.gsub(current_dir, "(.*[/\\])(.*)", "%2"))
end

wezterm.on("format-tab-title", function(tab)
  return wezterm.format({
    { Attribute = { Intensity = "Half" } },
    { Text = string.format(" %s  ", tab.tab_index + 1) },
    "ResetAttributes",
    { Text = get_process(tab) },
    { Text = " " },
    { Text = get_current_working_dir(tab) },
    { Foreground = { Color = colors.base } },
    { Text = "  ▕" },
  })
end)

wezterm.on("update-right-status", function(window)
  window:set_right_status(wezterm.format({
    { Attribute = { Intensity = "Bold" } },
    { Text = wezterm.strftime(" %A, %d %B %Y %I:%M %p ") },
  }))
end)

--[[ local catppuccin = require("colors/catppuccin").setup { ]]
--[[   -- whether or not to sync with the system's theme ]]
--[[   sync = true, ]]
--[[   -- the flavours to switch between when syncing ]]
--[[   -- available flavours: "latte" | "frappe" | "macchiato" | "mocha" ]]
--[[   sync_flavours = { ]]
--[[     light = "macchiato", ]]
--[[     dark = "macchiato" ]]
--[[   }, ]]
--[[   -- the default/fallback flavour, when syncing is disabled ]]
--[[   flavour = "macchiato" ]]
--[[ } ]]

return {
  font = wezterm.font_with_fallback({
    "FiraCode Nerd Font",
    weight = "Retina"
  }),
  color_scheme = 'zenwritten_light',
  font_size = 12,
  --line_height = 1.0,
  max_fps = 120,
  window_close_confirmation = "NeverPrompt",
  audible_bell = "Disabled",
  initial_cols = 110,
  initial_rows = 25,
  show_new_tab_button_in_tab_bar = false,
  window_background_opacity = 1.0,
  tab_max_width = 50,
  disable_default_key_bindings = false,
  enable_tab_bar = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  enable_scroll_bar = false,
  hide_tab_bar_if_only_one_tab = true,
}
