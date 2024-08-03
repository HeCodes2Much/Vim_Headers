--[[
------------------------------------------------------------------------------
-- Path          - .config/nvim/lua/headsup.lua
-- GitHub        - https://github.com/The-Repo-Club/
-- Author        - The-Repo-Club [wayne6324@gmail.com]
-- Start On      - Sun 31 October 2021, 01:17:35 am (GMT)
-- Modified On   - Sat 29 January 2022, 06:25:00 pm (GMT) 
------------------------------------------------------------------------------
-- Version=2022.01.28
------------------------------------------------------------------------------
-- Add and update header and its timestamp, including instances of `Version=''`
--  variable (assignment) datestamp in shell scripts, if thisvariable is found.
--  Also cleans up spacing. Does not save; that's up to you.
--
-- To use, enter <leader>trchp to place it, and <leader>trchu to update it & the
-- aforementioned variable's value, if it's found at the very start of a line.
-- To update the version run <leader>trcvp
------------------------------------------------------------------------------
]]

local M = {}

local function get_date()
    return os.date("%a %d %B %Y, %I:%M:%S %p (GMT)")
end

local function get_header_line()
    return string.rep("-", 81)
end

local function get_file()
    local home = os.getenv("HOME")
    local fname = vim.fn.expand("%")
    return "Path          - " .. home .. "/" .. fname
end

local function get_github()
    if vim.g.header_github then
        return "GitHub        - https://github.com/" .. vim.g.header_github .. "/"
    else
        return "GitHub        - https://github.com/Example/"
    end
end

local function get_author()
    local username = vim.g.header_username or "Example"
    local email = vim.g.header_email or "example@gmail.com"
    return "Author        - " .. username .. " [" .. email .. "]"
end

local function get_start()
    return "Start On      - " .. get_date()
end

local function get_modified()
    return "Modified On   - " .. get_date()
end

local function get_version()
    return "Version=" .. os.date("%Y.%m.%d")
end

local function insert_lines(lines)
    for i, line in ipairs(lines) do
        vim.fn.append(i, line)
    end
end

local function place_header()
    local filetype = vim.bo.filetype
    local lines = {}

    if filetype == "sh" or filetype == "fish" or filetype == "perl" or filetype == "python" or
       filetype == "ruby" or filetype == "zsh" then
        table.insert(lines, "#!/usr/bin/env " .. (vim.g.header_sh or filetype))
        table.insert(lines, "# -*-coding:utf-8 -*-")
    end

    table.insert(lines, "# " .. get_header_line())
    table.insert(lines, "# " .. get_file())
    table.insert(lines, "# " .. get_github())
    table.insert(lines, "# " .. get_author())
    table.insert(lines, "# " .. get_start())
    table.insert(lines, "# " .. get_modified())
    table.insert(lines, "# " .. get_header_line())
    table.insert(lines, get_version())
    table.insert(lines, "# " .. get_header_line())
    table.insert(lines, "")

    insert_lines(lines)
end

local function update_header()
    local modified_pattern = "Modified On%s*- "
    local line_nr = vim.fn.search(modified_pattern, "n")
    if line_nr > 0 then
        local modified_line = "Modified On   - " .. get_date()
        vim.fn.setline(line_nr, modified_line)
    end
end

function M.headsup(action)
    if action == "place" then
        place_header()
    elseif action == "update" then
        update_header()
    end
end

vim.api.nvim_set_keymap("n", "<leader>trchp", ":lua require'headsup'.headsup('place')<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>trchu", ":lua require'headsup'.headsup('update')<CR>", { noremap = true, silent = true })

if vim.g.header_auto_update == true then
    vim.cmd [[autocmd BufWritePre * lua require'headsup'.headsup('update')]]
end

return M
