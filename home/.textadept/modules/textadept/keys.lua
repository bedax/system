function ctrl(key, fn)
   keys["c"..key] = fn
end

function alt(key, fn)
   keys[CURSES and "cm"..key or "ca"..key] = fn
end


-- Unused
-- ['l', 'm', 'p']


-- File
local rooted_open = require("rooted_open")
ctrl("n", buffer.new)
ctrl("o", rooted_open.quick_open)
alt("o", rooted_open.quick_open_home)
ctrl("i", io.open_recent_file)
alt("i", io.open_file)
ctrl("f4", io.reload_file)
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
ctrl("h", textadept.editing.highlight_word)
ctrl("d", textadept.editing.block_comment)
ctrl("k", edit_menu[_L['_Filter Through']][2])
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
ctrl("s\t", buffer_menu[_L['_Previous Buffer']][2])
ctrl("\t", buffer_menu[_L['_Next Buffer']][2])
ctrl("b", function() ui.switch_buffer(true) end)

-- View
local view_menu = textadept.menu.menubar[_L['_View']]
ctrl("pgup", view_menu[_L['_Previous View']][2])
ctrl("pgdn", view_menu[_L['_Next View']][2])
ctrl("\n", view_menu[_L['Split View _Vertical']][2])
alt("\n", view_menu[_L['Split View _Horizontal']][2])
ctrl("\b", view_menu[_L['_Unsplit View']][2])
alt("\b", view_menu[_L['Unsplit _All Views']][2])
ctrl("-", buffer.zoom_out)
ctrl("=", buffer.zoom_in)
ctrl("0", view_menu[_L['_Reset Zoom']][2])

-- Other
ctrl("t", function() ui.tabs = not ui.tabs end)


keys.find_incremental = {
   ["\n"] = function()
      ui.find.find_entry_text = ui.command_entry:get_text() -- save
      ui.find.find_incremental(ui.command_entry:get_text(), true, true)
   end,

   ["c\n"] = function()
      ui.find.find_incremental(ui.command_entry:get_text(), false, true)
   end
}

keys.filter_through = {
   ["\n"] = function()
      return ui.command_entry.finish_mode(textadept.editing.filter_through)
   end
}
