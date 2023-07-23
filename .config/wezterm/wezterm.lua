local wezterm = require 'wezterm'


return {
  font = wezterm.font_with_fallback({
    "SF Mono",
  }),
  color_scheme = 'zenwritten_dark',
  font_size = 12,
  window_close_confirmation = "NeverPrompt",
  audible_bell = "Disabled",
  initial_cols = 110,
  initial_rows = 25,
  show_new_tab_button_in_tab_bar = false,
  window_background_opacity = 1.0,
  tab_max_width = 50,
  disable_default_key_bindings = false,
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  tab_bar_at_bottom = true,
  use_fancy_tab_bar = false,
  enable_scroll_bar = false,
}
