-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- File: ~/.config/nvim/lua/config/keymaps.lua

vim.keymap.set("n", "\\r", function()
  if vim.bo.filetype == "cpp" then
    local file = vim.fn.expand("%:p")
    local output = vim.fn.expand("%:p:r")

    vim.cmd("write")

    -- Updated with Command 4 flags + a "read" command to keep terminal open
    local compile_flags = "-std=c++17 -Wall -Wextra -Wshadow -O3 -fsanitize=address,undefined -fno-omit-frame-pointer"
    local cmd = string.format(
      "clang++ %s '%s' -o '%s' && '%s'; echo ''; read -n 1 -s -p 'Process finished. Press any key to close...'",
      compile_flags,
      file,
      output,
      output
    )

    if _G.Snacks then
      Snacks.terminal.get(cmd, {
        win = {
          position = "float",
          border = "rounded",
          title = " Compile & Run (Clang++) ",
          title_pos = "center",
        },
      })
    else
      vim.cmd("split | term " .. cmd)
    end

    vim.cmd("startinsert")
  else
    vim.notify("This mapping is for C++ files only.", vim.log.levels.INFO)
  end
end, { desc = "Clang++: Compile & Run current file" })
