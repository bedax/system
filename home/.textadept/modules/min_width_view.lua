function minimum_width()
   local ui_width = ui.size[1]
   local ui_width_half = ui_width / 2
   local width = ui_width_half

   if buffer.edge_column then
      local column_style = _SCINTILLA.constants.STYLE_DEFAULT
      local column_width = buffer:text_width(column_style, "M")
      local columns_count = buffer.edge_column + 2
      local columns_width = columns_count * column_width
      local margin_width = buffer.margin_width_n[0]
      local minimum_width = margin_width + columns_width

      if ui_width >= (minimum_width * 1.5) then
         width = minimum_width
      end
   end

   return width
end

function set_main_view_size()
   if _VIEWS[1].size == nil then
      timeout(1/60, set_main_view_size)
   else
      local minimum_width = minimum_width()
      if _VIEWS[1].size < minimum_width then
         _VIEWS[1].size = minimum_width
      end
   end
end

events.connect(events.VIEW_NEW, function()
   if #_VIEWS == 2 then
      set_main_view_size()
   end
end)
