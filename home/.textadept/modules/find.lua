local M = {}


-- buffer.search_flags = buffer.FIND_WHOLEWORD + buffer.FIND_MATCHCASE


-- search dialogs (find incremental, etc) should start with the current selection in its input box, or the word under the cursor, or the previous search
   -- highlight the input box content when launching the search dialog (replacing ctrl+h)
      -- when enter is pressed (or ctrl+h), clear highlights and rehighlight the entered text
         -- https://foicica.com/wiki/goto-nearest-occurrence
   -- if getting initial text from selection, deselect after getting it

-- ctrl+h case sensitive
-- ctrl+alt+h case insensitive
-- ctrl+f case insensitive
-- ctrl+alt+f case sensitive


-- see: https://foicica.com/wiki/goto-nearest-occurrence
M.selected_text = function()
   local s = buffer.selection_start
   local e = buffer.selection_end

   if s == e then
      s = buffer:word_start_position(s)
      e = buffer:word_end_position(s)
   end

   local word = buffer:text_range(s, e)

   if word == "" then
      return nil
   else
      return word
   end
end

M.input_text = function()

end

M.find_dialog = function()
   ui.print(selected_text())
   --ui.find.find_incremental()
   --ui.command_entry:set_text("text")
end

M.replace_dialog = function()
   search_menu[_L["_Find"]][2]()
   ui.find.find_entry_text = "text"
end


return M
