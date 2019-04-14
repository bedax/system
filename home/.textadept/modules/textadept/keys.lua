function ctrl(key, fn)
   keys["c"..key] = fn
end

function alt(key, fn)
   keys[CURSES and "cm"..key or "ca"..key] = fn
end


-- File
ctrl("n", buffer.new)
ctrl("o", io.open_file)
alt("o", io.reload_file)
ctrl("s", io.save_file)
alt("s", io.save_file_as)
ctrl("w", io.close_buffer)
alt("w", io.close_all_buffers)
ctrl("q", quit)

-- Edit
local edit_menu = textadept.menu.menubar[_L['_Edit']]
ctrl("z", buffer.undo)
ctrl("y", buffer.redo)
ctrl("x", buffer.cut)
ctrl("c", buffer.copy)
ctrl("v", buffer.paste)
ctrl("a", buffer.select_all)
ctrl("j", edit_menu[_L['_Match Brace']][2])
ctrl("m", textadept.editing.highlight_word)
ctrl("d", textadept.editing.block_comment)
ctrl("u", buffer.lower_case)
alt("u", buffer.upper_case)

-- Search
local search_menu = textadept.menu.menubar[_L['_Search']]
ctrl("f", ui.find.find_incremental)
ctrl("r", search_menu[_L['_Find']][2])
ctrl("g", textadept.editing.goto_line)

-- Tools
local tools_menu = textadept.menu.menubar[_L['_Tools']]
ctrl("e", tools_menu[_L['Command _Entry']][2])
alt("e", tools_menu[_L['Select Co_mmand']][2])

-- Buffer
local buffer_menu = textadept.menu.menubar[_L['_Buffer']]
ctrl("pgup", buffer_menu[_L['_Previous Buffer']][2])
ctrl("pgdn", buffer_menu[_L['_Next Buffer']][2])
ctrl("b", function() ui.switch_buffer(true) end)

-- Help
local help_menu = textadept.menu.menubar[_L['_Help']]
keys["f1"] = help_menu[_L['Show _Manual']][2]


keys.filter_through = {
   ["\n"] = function()
      return ui.command_entry.finish_mode(textadept.editing.filter_through)
   end
}

keys.find_incremental = {
   ["\n"] = function()
      ui.find.find_entry_text = ui.command_entry:get_text() -- save
      ui.find.find_incremental(ui.command_entry:get_text(), true, true)
   end,

   ['c\n'] = function()
      ui.find.find_incremental(ui.command_entry:get_text(), false, true)
   end
}
