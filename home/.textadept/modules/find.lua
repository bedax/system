-- buffer.search_flags = buffer.FIND_WHOLEWORD + buffer.FIND_MATCHCASE


-- see: https://foicica.com/wiki/goto-nearest-occurrence
function selected_text()
   local s = buffer.selection_start
   local e = buffer.selection_end

   if s == e then
      s = buffer:word_start_position(s)
      e = buffer:word_end_position(s)
   end

   local word = buffer:text_range(s, e)

   if word == ''
      return nil
   else
      return word
   end
end

function input_text()

end

function find_dialog()
   ui.print(selected_text())
   --ui.find.find_incremental()
   --ui.command_entry:set_text("text")
end

function replace_dialog()
   search_menu[_L["_Find"]][2]()
   ui.find.find_entry_text = "text"
end
