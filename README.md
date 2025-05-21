# Neovim Plugin Configuration & Key Cheatsheet

This document outlines the various Lua plugins configured in this Neovim setup, their purposes, and associated key mappings or commands.

## `yetone/avante.nvim` (AI Assistant)

*   **Purpose:** AI assistant emulating Cursor AI IDE for code suggestions, chat, refactoring. Supports various AI providers.
*   **Key Mappings:** (Plugin defaults, as `behaviour.auto_set_keymaps` is true in its configuration)
    *   `<Leader>aa`: Show sidebar
    *   `<Leader>at`: Toggle sidebar visibility
    *   `<Leader>ar`: Refresh sidebar
    *   `<Leader>af`: Switch sidebar focus
    *   `<Leader>a?`: Select model
    *   `<Leader>ae`: Edit selected blocks
    *   `<Leader>aS`: Stop current AI request
    *   `<Leader>ah`: Select between chat histories
    *   **Diff View:**
        *   `co`: Choose ours
        *   `ct`: Choose theirs
        *   `ca`: Choose all theirs
        *   `c0`: Choose none
        *   `cb`: Choose both
        *   `cc`: Choose cursor
        *   `]x`: Move to next conflict
        *   `[x`: Move to previous conflict
    *   **Suggestions:**
        *   `<M-l>`: Accept suggestion
        *   `<M-]>`: Next suggestion
        *   `<M-[>`: Previous suggestion
        *   `<C-]>`: Dismiss suggestion
    *   **Results Navigation:**
        *   `]]`: Jump to next codeblock
        *   `[[`: Jump to previous codeblock
    *   **Avante Input UI:**
        *   `<CR>` (Normal mode): Submit
        *   `<C-s>` (Insert mode): Submit
        *   `<C-c>`, `<Esc>`, `q` (Normal mode): Cancel
        *   `<C-c>` (Insert mode): Cancel
    *   **Sidebar (when active):**
        *   `A`: Apply all
        *   `a`: Apply at cursor
        *   `r`: Retry user request
        *   `e`: Edit user request
        *   `<Tab>`: Switch windows (within Avante UI)
        *   `<S-Tab>`: Reverse switch windows
        *   `d`: Remove file (from context)
        *   `@`: Add file (to context)
        *   `<Esc>`, `q`: Close sidebar/Avante UI

## Colorschemes (`lua/ftl/lazy/colors.lua`)

*   **Purpose:** Manages several colorscheme plugins. A Lua function `ColorMyPencils(color)` (defined in `colors.lua`) is used to apply the chosen scheme (defaulting to `rose-pine-moon`) and make the background transparent. This function is often called on startup or by other plugins like `zen-mode.nvim`.
*   **Configured Colorscheme Plugins:**
    *   `erikbackman/brightburn.vim`
    *   `folke/tokyonight.nvim` (configured for "storm" style, transparent)
    *   `ellisonleao/gruvbox.nvim` (configured with specific styling options)
    *   `rose-pine/neovim` (named `rose-pine`; the `rose-pine-moon` variant is the default applied by `ColorMyPencils()`)
*   **Key Mappings:** None. The theme is set programmatically, primarily by the `ColorMyPencils` function.

## `stevearc/conform.nvim` (Formatter)

*   **Purpose:** A lightweight yet powerful formatting plugin for Neovim. It is configured in `lua/ftl/lazy/conform.lua` to use `stylua` for Lua files and `gofmt` for Go files.
*   **Key Mappings:** None are defined in `lua/ftl/lazy/conform.lua`. Formatting is not set up to run automatically on save in this file.
*   **Usage:**
    *   Manually trigger formatting: `:lua require("conform").format()`
    *   Users can define their own key mappings, for example:
        ```lua
        vim.keymap.set({"n", "v"}, "<leader>f", function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end, { desc = "Format code" })
        ```
    *   Inspect formatters: `:ConformInfo` (shows available formatters and logs).

## `zbirenbaum/copilot.lua` (GitHub Copilot Client)

*   **Purpose:** Integrates GitHub Copilot to provide AI-powered code suggestions. It's configured to auto-trigger suggestions when entering insert mode. The Copilot panel for browsing multiple suggestions is disabled in this configuration.
*   **Key Mappings:**
    *   Accept suggestion: `<C-l>` (Customized in `lua/ftl/lazy/copilot.lua`)
    *   Next suggestion: `<M-]>` (As per plugin default, configured in `lua/ftl/lazy/copilot.lua`)
    *   Previous suggestion: `<M-[>` (As per plugin default, configured in `lua/ftl/lazy/copilot.lua`)
    *   Dismiss suggestion: `<C-]>` (Plugin's default, as it's not overridden in `lua/ftl/lazy/copilot.lua`)
*   **Commands:**
    *   `:Copilot auth`: To authenticate with GitHub Copilot (also run as a build step).

## Debug Adapter Protocol (DAP) (`mfussenegger/nvim-dap`, `rcarriga/nvim-dap-ui`, `jay-babu/mason-nvim-dap.nvim`)

*   **Purpose:** Provides a full debugging experience within Neovim, including a UI and management of debug adapters. The Go debugger (`delve`) is explicitly configured and installed.
*   **Key Mappings:**
    *   `<F8>`: Continue (`dap.continue`)
    *   `<F10>`: Step Over (`dap.step_over`)
    *   `<F11>`: Step Into (`dap.step_into`)
    *   `<F12>`: Step Out (`dap.step_out`)
    *   `<leader>b`: Toggle Breakpoint (`dap.toggle_breakpoint`)
    *   `<leader>B`: Set Conditional Breakpoint (prompts for condition)
    *   **DAP UI Toggles:**
        *   `<leader>dr`: Toggle REPL UI
        *   `<leader>ds`: Toggle Stacks UI
        *   `<leader>dw`: Toggle Watches UI
        *   `<leader>db`: Toggle Breakpoints UI
        *   `<leader>dS`: Toggle Scopes UI
        *   `<leader>dc`: Toggle Console UI

## `tpope/vim-fugitive` (Git Wrapper)

*   **Purpose:** An extensive Git wrapper for Neovim, allowing users to perform most Git operations directly from the editor.
*   **Key Mappings (defined in `lua/ftl/lazy/fugitive.lua`):**
    *   `<leader>gs`: Open Git status window (`vim.cmd.Git`).
    *   `gu` (Normal mode, typically in a diff view): Get changes from "ours" (`:diffget //2`).
    *   `gh` (Normal mode, typically in a diff view): Get changes from "theirs" (`:diffget //3`).
    *   **In Fugitive buffers (e.g., status window, `ft=fugitive`):**
        *   `<leader>p`: `:Git push`
        *   `<leader>P`: `:Git pull --rebase`
        *   `<leader>t`: Partially types out `:Git push -u origin ` (user completes the branch name).
*   **Common Commands:** `:G` or `:Gstatus` (status window), `:Git <args>` (e.g., `:Git commit`), `:Gdiffsplit`, `:Gblame`, `:Gwrite`, `:GBrowse`. The status window has many built-in mappings (e.g., `s` to stage, `u` to unstage, `cc` to commit, `dd` to diff).

## `vuciv/golf` (Code Golfing Game)

*   **Purpose:** A Vim/Neovim plugin that provides a challenge-based keystroke game. Users are tasked with transforming a starting text to a target text using the fewest keystrokes possible. It includes daily challenges, challenges by difficulty/tag/date, keystroke tracking, scoring, and leaderboards.
*   **Key Mappings:** None are defined in `lua/ftl/lazy/golf.lua`. The plugin is used via commands.
*   **Commands:**
    *   `:Golf today`: Play today's challenge.
    *   `:Golf [easy|medium|hard]`: Play a random challenge by difficulty.
    *   `:Golf`: Play a random challenge (any difficulty).
    *   `:Golf tag <tag-name>`: Play a random challenge by tag.
    *   `:Golf date <YYYY-MM-DD>`: Play a challenge from a specific date.
    *   `:Golf leaderboard [date <YYYY-MM-DD> | id <challenge-id>]`: View leaderboards.
    *   `:Golf help`: Show help.

## `ThePrimeagen/harpoon` (branch: `harpoon2`) (File Navigation)

*   **Purpose:** Harpoon is a Neovim plugin designed to optimize file navigation by allowing users to create a list of frequently accessed files ("harpooned" files) and quickly jump to them.
*   **Key Mappings (defined in `lua/ftl/lazy/harpoon.lua`):**
    *   `<leader>a`: Add current file to the end of the Harpoon list.
    *   `<leader>A`: Add current file to the beginning of the Harpoon list.
    *   `<leader><C-h>`: Replace file at index 1 in the list with the current file.
    *   `<leader><C-t>`: Replace file at index 2 with the current file.
    *   `<leader><C-n>`: Replace file at index 3 with the current file.
    *   `<leader><C-s>`: Replace file at index 4 with the current file.
    *   `<C-e>`: Toggle the Harpoon quick menu to see the list of marked files.
    *   `<C-h>`: Go to file at index 1 in the list.
    *   `<C-t>`: Go to file at index 2 in the list.
    *   `<C-n>`: Go to file at index 3 in the list.
    *   `<C-s>`: Go to file at index 4 in the list.

## Language Server Protocol (LSP) & Autocompletion (`neovim/nvim-lspconfig`, `williamboman/mason.nvim`, etc.)

*   **Plugins:**
    *   `neovim/nvim-lspconfig`: Main plugin for configuring LSP servers.
    *   `williamboman/mason.nvim`: Manages installation of LSP servers, linters, formatters.
    *   `williamboman/mason-lspconfig.nvim`: Connects Mason with `nvim-lspconfig`.
    *   `hrsh7th/nvim-cmp` (and its sources: `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `cmp-cmdline`, `cmp_luasnip`).
    *   `L3MON4D3/LuaSnip` (Snippet engine, see Snippets section).
    *   `j-hui/fidget.nvim`: UI for LSP progress.
*   **Purpose:** Manages LSP server installation, configuration, and provides autocompletion via `nvim-cmp`.
*   **Configured Servers (via `ensure_installed` in `lsp.lua`):** `lua_ls`, `rust_analyzer`, `gopls`.
*   A custom handler is also provided for `zls` (Zig Language Server), which would need to be manually installed via Mason.
*   **Key Mappings (defined in `lua/ftl/lazy/lsp.lua` for `nvim-cmp`):**
    *   `<C-p>`: Select previous item in completion menu.
    *   `<C-n>`: Select next item in completion menu.
    *   `<C-y>`: Confirm selected completion.
    *   `<C-Space>`: Trigger completion manually.
*   **LSP Actions (e.g., Go to Definition, Hover, Find References, Diagnostics Navigation):**
    *   **No explicit key mappings for these common LSP actions are defined in `lua/ftl/lazy/lsp.lua`.** Users need to define these themselves (often in an `on_attach` function for LSP servers) or use manual Lua commands (e.g., `:lua vim.lsp.buf.definition()`).

## `nvim-neotest/neotest` & `fredrikaverpil/neotest-golang` (Test Runner)

*   **Purpose:** An extensible test runner framework for Neovim. This configuration specifically sets it up for Go tests using the `neotest-golang` adapter, including DAP integration for debugging tests (`justMyCode = false`).
*   **Key Mappings (defined in `lua/ftl/lazy/neotest.lua`):**
    *   `<leader>tr`: Run the nearest test.
    *   `<leader>tv`: Toggle the test summary window.
    *   `<leader>ts`: Run the current test suite.
    *   `<leader>td`: Debug the nearest test (using DAP).
    *   `<leader>to`: Open the test output panel.
    *   `<leader>ta`: Run all tests in the current working directory.

## `toppair/peek.nvim` (Markdown Previewer)

*   **Purpose:** A live Markdown preview plugin for Neovim. It is also configured for `.conf` files. It uses Deno and opens a preview in a webview or browser with features like live updates and synchronized scrolling.
*   **Key Mappings:** None are defined in `lua/ftl/lazy/peek.lua`.
*   **Commands (defined in `lua/ftl/lazy/peek.lua`):**
    *   `:PeekOpen`: Opens the preview window for the current supported file (Markdown, conf).
    *   `:PeekClose`: Closes the preview window.
*   **Preview Window Keybindings (active when preview window is focused):**
    *   `k`/`j`: Scroll up/down.
    *   `u`/`d`: Scroll up/down half a page.
    *   `g`/`G`: Scroll to top/bottom.

## Snippets (`L3MON4D3/LuaSnip` & `rafamadriz/friendly-snippets`)

*   **Purpose:** `L3MON4D3/LuaSnip` is a snippet engine, and `rafamadriz/friendly-snippets` provides a collection of pre-defined snippets. This setup integrates with `nvim-cmp` for snippet suggestions.
*   **Key Mappings (for manual snippet interaction, defined in `lua/ftl/lazy/snippets.lua`):**
    *   `<C-s>e` (Insert mode): Manually expand the current snippet.
    *   `<C-s>;` (Insert and Select modes): Jump to the next placeholder within an active snippet.
    *   `<C-s>,` (Insert and Select modes): Jump to the previous placeholder.
    *   `<C-E>` (Insert and Select modes): If a snippet choice node is active, cycle to the next choice.
*   **Note:** Snippets are also expanded by selecting them from the `nvim-cmp` completion menu.

## `TabbyML/vim-tabby` (Self-hosted AI Coding Assistant)

*   **Purpose:** An AI coding assistant providing real-time, multi-line code and function suggestions. It requires a separate Tabby server (self-hosted or remote) and the `tabby-agent` (typically installed via npm).
*   **Key Mappings:** The `lua/ftl/lazy/tabby.lua` file provides no custom key mappings. The plugin uses its **default keybindings**:
    *   `<Tab>`: Accept the current inline completion suggestion.
    *   `<C-\>` (Control + Backslash): Manually trigger an inline completion or dismiss the current one.
*   **Configuration:** The setup in `ftl` is minimal, relying on plugin defaults for agent commands and triggers.

## `nvim-telescope/telescope.nvim` (Fuzzy Finder)

*   **Purpose:** A highly extensible fuzzy finder plugin for Neovim. It enables users to quickly search for and interact with various sources like files, Git-tracked files, buffer contents (grep), and help tags. It uses default settings for themes, layouts, etc.
*   **Key Mappings (defined in `lua/ftl/lazy/telescope.lua`):**
    *   `<leader>pf`: Find files (`builtin.find_files`).
    *   `<C-p>`: Find Git-tracked files (`builtin.git_files`).
    *   `<leader>pws`: Grep for the word under the cursor (cword).
    *   `<leader>pWs`: Grep for the WORD under the cursor (cWORD, space-separated).
    *   `<leader>ps`: Prompts for input and greps for that string.
    *   `<leader>vh`: Search Neovim help tags (`builtin.help_tags`).

## `tjdevries/php.nvim` (PHP/Blade Enhancements)

*   **Purpose:** This plugin aims to improve the PHP development experience in Neovim, primarily by automatically setting up `tree-sitter-blade` and its associated queries for enhanced Blade template support (often used with Laravel).
*   **Key Mappings:** None are defined in `lua/ftl/lazy/tj.lua`.
*   **Functionality:** Its current main role is foundational (providing Treesitter queries for Blade templates). The plugin's documentation lists other features like Composer integration as TODOs.

## `nvim-treesitter/nvim-treesitter` & `nvim-treesitter/nvim-treesitter-context` (Syntax Parsing & Context Display)

*   **Purpose:**
    *   `nvim-treesitter`: Provides incremental parsing of code into syntax trees for more accurate syntax highlighting, indentation, and a foundation for other language-aware features.
    *   `nvim-treesitter-context`: Displays the current code context (e.g., function/class name) at the top of the editor.
*   **Installed Parsers (`ensure_installed` for `nvim-treesitter`):** `vimdoc`, `javascript`, `typescript`, `c`, `lua`, `rust`, `jsdoc`, `bash`, `go`. A custom parser for `templ` language is also configured and set to `auto_install = true`.
*   **Enabled `nvim-treesitter` Modules:**
    *   **Highlighting:** Enabled. It's disabled for `html` and `go` filetypes, and for files larger than 100KB. For Markdown, additional Vim regex highlighting is used alongside Treesitter.
    *   **Indentation:** Enabled.
*   **`nvim-treesitter-context`:** Enabled, shows full context block with line numbers.
*   **Key Mappings:** None are defined in `lua/ftl/lazy/treesitter.lua`.

## `folke/trouble.nvim` (Diagnostics & List Viewer)

*   **Purpose:** Provides a structured and visually appealing list for diagnostics (errors, warnings), LSP results (references, definitions), quickfix items, etc. In this configuration, icons are disabled.
*   **Key Mappings (defined in `lua/ftl/lazy/trouble.lua`):**
    *   `<leader>tt`: Toggle the Trouble window.
    *   `[t`: Navigate to the next item in the Trouble list (jumps to source, skips groups).
    *   `]t`: Navigate to the previous item in the Trouble list (jumps to source, skips groups).

## `mbbill/undotree` (Undo Tree Visualizer)

*   **Purpose:** Visualizes Neovim's undo history as a tree, allowing easier navigation and restoration of previous states, including divergent branches. Supports persistent undo.
*   **Key Mappings (defined in `lua/ftl/lazy/undotree.lua`):**
    *   `<leader>u`: Toggle the Undotree window (`vim.cmd.UndotreeToggle`).
*   **Note:** The Undotree window itself has internal keybindings for navigation (press `?` in its window for help).

## `theprimeagen/vim-be-good` (Vim Proficiency Game)

*   **Purpose:** A game designed to help Neovim users practice and improve their Vim movement and command skills through various challenges.
*   **Key Mappings:** None defined in `lua/ftl/lazy/vimbegood.lua`. The plugin is command-driven.
*   **Commands:**
    *   Start in an empty buffer.
    *   `:VimBeGood`: Lists available games.
    *   `:VimBeGood <game_name>`: Starts a specific game (e.g., `:VimBeGood relative`).

## `folke/zen-mode.nvim` (Distraction-Free Mode)

*   **Purpose:** Provides a distraction-free coding environment by centering the current buffer in a new floating window and hiding UI elements.
*   **Key Mappings (defined in `lua/ftl/lazy/zenmode.lua`):**
    *   `<leader>zz`: Toggles Zen mode with a window width of 90 columns, line numbers enabled, relative numbers enabled, wrap disabled, and applies `ColorMyPencils()` theme.
    *   `<leader>zZ`: Toggles Zen mode with a window width of 80 columns, line numbers disabled, relative numbers disabled, wrap disabled, color column disabled, and applies `ColorMyPencils()` theme.

## `nvim-lua/plenary.nvim` (Utility Library)

*   **Purpose:** A Lua utility library for Neovim, providing a wide range of helper functions and modules for plugin developers (e.g., async operations, file system utilities, testing tools). It's a dependency for many other plugins in this setup.
*   **Key Mappings:** None. This is a library and not directly interacted with by end-users via keymaps.

## `eandrju/cellular-automaton.nvim` (Visual Animation)

*   **Purpose:** Runs cellular automaton animations (e.g., "Game of Life", "make_it_rain") in Neovim, using the current buffer's content as the initial state. Described by its author as a "useless plugin" for fun/visual stimulation. Requires a Treesitter parser for the current buffer.
*   **Key Mappings:** None defined in `lua/ftl/lazy/init.lua`.
*   **Commands:**
    *   `:CellularAutomaton <animation_name>` (e.g., `:CellularAutomaton make_it_rain`).
    *   Close animation window: `q`, `<Esc>`, or `<CR>`.
