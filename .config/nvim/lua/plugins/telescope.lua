local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local status_ok, actions = pcall(require, "telescope.actions")
if not status_ok then
  return
end

telescope.setup({
  defaults = {
    file_ignore_patterns = {
			".git/",
			"node_modules/*",
		},
    mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			},
			n = {
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
			},
		},
	},

  pickers = {
    find_files = {
      find_command = {
        "fd",
        "-HI",
        "--type",
        "file",
        "--hidden",
      }
    }
  },
  extensions = {
    fzy = {
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
    }
  }
})

telescope.load_extension("fzy_native")
telescope.load_extension("project")
