local map = vim.keymap.set
map('n', '<leader>bn', ':MCPHub use binary_ninja_mcp decompile main<CR>', { desc = 'Binja MCP' })
map('n', '<leader>ob', ':MCPHub use obsidian write [[CycleForge]]<CR>', { desc = 'Obsidian note' })