function ctrl(key, fn)
   keys["c"..key] = fn
end

function alt(key, fn)
   keys[CURSES and "cm"..key or "ca"..key] = fn
end


-- Unused
-- ["l", "m"]


-- File
ctrl("n", buffer.new)
ctrl("o", require("open").quick_open)
alt("o", require("open").quick_open_home)
ctrl("i", io.open_file)
ctrl("p", io.open_recent_file)
ctrl("s", io.save_file)
alt("s", io.save_file_as)
ctrl("w", io.close_buffer)
alt("w", io.close_all_buffers)
ctrl("q", quit)

-- Edit
local edit_menu = textadept.menu.menubar[_L["_Edit"]]
ctrl("z", buffer.undo)
ctrl("y", buffer.redo)
ctrl("x", buffer.cut)
ctrl("c", buffer.copy)
ctrl("v", buffer.paste)
ctrl("a", buffer.select_all)
ctrl("j", edit_menu[_L["_Match Brace"]][2])
ctrl("h", textadept.editing.highlight_word)
ctrl("d", textadept.editing.block_comment)
ctrl("k", edit_menu[_L["_Filter Through"]][2])
ctrl("u", buffer.lower_case)
alt("u", buffer.upper_case)

-- Search
local search_menu = textadept.menu.menubar[_L["_Search"]]
ctrl("f", ui.find.find_incremental)
ctrl("r", search_menu[_L["_Find"]][2])
ctrl("g", textadept.editing.goto_line)

-- Tools
local tools_menu = textadept.menu.menubar[_L["_Tools"]]
ctrl("e", tools_menu[_L["Command _Entry"]][2])
alt("e", tools_menu[_L["Select Co_mmand"]][2])

-- Buffer
local buffer_menu = textadept.menu.menubar[_L["_Buffer"]]
ctrl("pgup", buffer_menu[_L["_Previous Buffer"]][2])
ctrl("pgdn", buffer_menu[_L["_Next Buffer"]][2])
ctrl("b", function() ui.switch_buffer(true) end)

-- View
local view_menu = textadept.menu.menubar[_L["_View"]]
ctrl("left", view_menu[_L["_Previous View"]][2])
ctrl("up", view_menu[_L["_Previous View"]][2])
ctrl("right", view_menu[_L["_Next View"]][2])
ctrl("down", view_menu[_L["_Next View"]][2])
ctrl("\b", require("split_view"))
ctrl("\n", view_menu[_L["_Unsplit View"]][2])
alt("\n", view_menu[_L["Unsplit _All Views"]][2])
ctrl("0", view_menu[_L["_Reset Zoom"]][2])
ctrl("-", buffer.zoom_out)
ctrl("=", buffer.zoom_in)

-- Other
ctrl(" ", require("open").terminal)
alt(" ", require("open").file_manager)
ctrl("t", function() ui.tabs = not ui.tabs end)
ctrl("`", require("minimum_width").set_first_view)
ctrl("1", require("minimum_width").set_second_view)


events.connect(events.SUSPEND, function()
   keys["cz"]()
   return true
end, 1)


ctrl("1", require("find").find_dialog)

ctrl("2", require("find").replace_dialog)



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
