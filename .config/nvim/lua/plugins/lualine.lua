-- File: plugins/lualine.lua
-- Description: Pacman config for lualine
-- Based on https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua

return { -- Statusline
  -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
  {
    "nvim-lualine/lualine.nvim",
    config = function(_)
      local lualine = require("lualine")
      local lualine_require = require("lualine_require")

      function loadcolors()
        -- Rose-pine palette
        local rosepine = require("rose-pine.palette")

        local colors = {
          bg = rosepine.base,
          fg = rosepine.text,
          yellow = rosepine.gold,
          cyan = rosepine.foam,
          black = rosepine.subtled,
          green = rosepine.pine,
          white = rosepine.text,
          magenta = rosepine.iris,
          blue = rosepine.rose,
          red = rosepine.love
        }

        return colors
      end

      local colors = loadcolors()

      local conditions = {
        buffer_not_empty = function()
          return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
        end,
        hide_in_width = function()
          return vim.fn.winwidth(0) > 80
        end,
        check_git_workspace = function()
          local filepath = vim.fn.expand("%:p:h")
          local gitdir = vim.fn.finddir(".git", filepath .. ";")
          return gitdir and #gitdir > 0 and #gitdir < #filepath
        end
      }


      -- Custom mode names.
      local mode_map = {
        ['COMMAND'] = 'COMMND',
        ['V-BLOCK'] = 'V-BLCK',
        ['TERMINAL'] = 'TERMNL',
      }
      local function fmt_mode(s) return mode_map[s] or s end

      local function parent_folder()
        local current_buffer = vim.api.nvim_get_current_buf()
        local current_file = vim.api.nvim_buf_get_name(current_buffer)
        local parent = vim.fn.fnamemodify(current_file, ':h:t')
        if parent == '.' then return '' end
        return parent .. '/'
      end

      -- Get the buffer's filename.
      local function get_current_filename()
        local bufname = vim.api.nvim_buf_get_name(0)
        return bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or ''
      end

      local function copilot_normal()
        local status = require('copilot.api').status.data.status
        if
            string.find(status, 'Online')
            or string.find(status, 'Enabled')
            or string.find(status, 'Normal')
            or string.find(status, 'InProgress')
        then
          return '  '
        end
        return ''
      end

      local function copilot_warn()
        local status = require('copilot.api').status.data.status
        if string.find(status, 'Warning') then return '  ' end
        return ''
      end

      local function copilot_error()
        local status = require('copilot.api').status.data.status
        if string.find(status, 'Error') then return '  ' end
        return ''
      end

      -- Config
      local config = {
        options = {
          -- Disable sections and component separators
          component_separators = "",
          section_separators = "",
          disabled_filetypes = { "Lazy", "NvimTree" },
          theme = require("zenbones.util").get_lualine_theme "zenwritten"
        },
        sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          -- These will be filled later
          lualine_c = {},
          lualine_x = {}
        },
        inactive_sections = {
          -- these are to remove the defaults
          lualine_a = {},
          lualine_b = {},
          lualine_y = {},
          lualine_z = {},
          lualine_c = {},
          lualine_x = {}
        }
      }

      -- Inserts a component in lualine_c at left section
      local function ins_left(component)
        table.insert(config.sections.lualine_c, component)
      end

      -- Inserts a component in lualine_x ot right section
      local function ins_right(component)
        table.insert(config.sections.lualine_x, component)
      end

      ins_left {
        'mode',
        fmt = fmt_mode,
        icon = { '' },
        right_padding = 2,
        separator = {
          right = '',
          left = '',
        },
        color = {
          fg = colors.bg,
          bg = colors.yellow
        }
      }

      ins_left {
        parent_folder,
        icon = { '  ' },
        cond = conditions.buffer_not_empty,
        separator = '',
        padding = 0,
        color = {
          fg = colors.black,
        }
      }

      ins_left {
        get_current_filename,
        separator = ' ',
        padding = 0,
        color = {
          fg = colors.black,
        }
      }


      ins_left {
        "branch",
        icon = '   ',
        color = {
          fg = colors.blue,
        }
      }

      ins_left {
        "diff",
        -- Is it me or the symbol for modified us really weird
        symbols = {
          added = " ",
          modified = " ",
          removed = " "
        },
        diff_color = {
          added = {
            fg = colors.green
          },
          modified = {
            fg = colors.yellow
          },
          removed = {
            fg = colors.red
          }
        },
        cond = conditions.hide_in_width
      }

      -- Insert mid section. You can make any number of sections in neovim :)
      -- for lualine it"s any number greater then 2
      ins_left { function()
        return "%="
      end }

      ins_right {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        symbols = {
          error = " ",
          warn = " ",
          info = " ",
        },
        diagnostics_color = {
          color_error = {
            fg = colors.red
          },
          color_warn = {
            fg = colors.yellow
          },
          color_info = {
            fg = colors.green
          }
        },
        colored = true,
        padding = 1
      }



      ins_right {
        -- Lsp server name .
        function()
          local msg = "null"
          local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
          local clients = vim.lsp.get_active_clients()
          if next(clients) == nil then
            return msg
          end
          for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
              return client.name
            end
          end
          return msg
        end,
        icon = " ",
        padding = 2,
        separator = ' ',
        color = {
          fg = colors.black,
        }
      }

      ins_right {
        copilot_normal,
        padding = 0
      }

      ins_right {
        copilot_warn,
        padding = 0
      }

      ins_right {
        copilot_error,
        padding = 0
      }

      ins_right {
        "location",
        icon = { '', align = 'left' },
        separator = { left = '' },
        color = {
          fg = colors.bg,
          bg = colors.yellow
        }
      }

      ins_right {
        "progress",
        icon = { '', align = 'left' },
        separator = { right = '' },
        left_padding = 2,
        color = {
          fg = colors.bg,
          bg = colors.yellow
        }
      }

      -- Now don"t forget to initialize lualine
      lualine.setup(config)
    end
  } }
