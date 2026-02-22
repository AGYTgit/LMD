-- swap : and ;
vim.cmd([[
    noremap : ;
    noremap ; :
]])

local k = vim.keymap

vim.g.mapleader = ","

-- delete comment -- needs a fix, deletes more then it should if there is no space before the comment, also works only for / as a start of the comment indicator
local function delete_comment_and_trim()
  local current_line_num = vim.api.nvim_win_get_cursor(0)[1]
  local line_content = vim.api.nvim_get_current_line()

  local earliest_comment_pos = nil

  local slash_comment_start = line_content:find(" // ", 1, true)
  local slash_star_comment_start = line_content:find(" /* ", 1, true)
  local hash_comment_start = line_content:find(" # ", 1, true)
  local dash_comment_start = line_content:find(" -- ", 1, true)
  local semicolon_comment_start = line_content:find(" ; ", 1, true)

  if slash_comment_start then
    earliest_comment_pos = slash_comment_start
  end

  if slash_star_comment_start then
    if not earliest_comment_pos or slash_star_comment_start < earliest_comment_pos then
      earliest_comment_pos = slash_star_comment_start
    end
  end

  if hash_comment_start then
    if not earliest_comment_pos or hash_comment_start < earliest_comment_pos then
      earliest_comment_pos = hash_comment_start
    end
  end

  if dash_comment_start then
    if not earliest_comment_pos or dash_comment_start < earliest_comment_pos then
      earliest_comment_pos = dash_comment_start
    end
  end

  if semicolon_comment_start then
    if not earliest_comment_pos or semicolon_comment_start < earliest_comment_pos then
      earliest_comment_pos = semicolon_comment_start
    end
  end

  if earliest_comment_pos then
    local start_col_to_delete = earliest_comment_pos - 1

    vim.api.nvim_buf_set_text(0, current_line_num - 1, start_col_to_delete, current_line_num - 1, #line_content, { "" })

    local function trim_trailing_whitespace(line_num_to_trim)
      local line_content_to_trim = vim.api.nvim_buf_get_lines(0, line_num_to_trim - 1, line_num_to_trim, false)[1]
      if line_content_to_trim then
        local trimmed_line = line_content_to_trim:gsub("%s+$", "")
        if trimmed_line ~= line_content_to_trim then
          vim.api.nvim_buf_set_lines(0, line_num_to_trim - 1, line_num_to_trim, false, { trimmed_line })
        end
      end
    end

    trim_trailing_whitespace(current_line_num)

    local new_line_content = vim.api.nvim_get_current_line()
    vim.api.nvim_win_set_cursor(0, { current_line_num, #new_line_content })
  end
end

vim.keymap.set("n", "<leader>dc", delete_comment_and_trim, {
  noremap = true,
  silent = true,
})

-- inspect
k.set("n", "<C-i>", "<cmd>Inspect<CR>")

-- clear search
k.set("n", "<leader>h", "<cmd>nohl<CR>", { noremap = true, silent = true })

-- create split
k.set("n", "<leader>sh", "<C-w>v", { noremap = true, silent = true })
k.set("n", "<leader>sv", "<C-w>s", { noremap = true, silent = true })

-- open nvim-tree
k.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

-- telescope
vim.g.telescope_key = " "
k.set("n", vim.g.telescope_key .. "f", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })
k.set("n", vim.g.telescope_key .. "g", "<cmd>Telescope live_grep<CR>", { noremap = true, silent = true })
k.set("n", vim.g.telescope_key .. "b", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
k.set("n", vim.g.telescope_key .. "h", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })
