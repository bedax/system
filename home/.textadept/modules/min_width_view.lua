local M = {}


M.minimum_width = function()
   local ui_width = ui.size[1]
   local ui_width_half = ui_width / 2
   local minimum_width = ui_width_half

   if buffer.edge_column then
      local column_style = _SCINTILLA.constants.STYLE_DEFAULT
      local column_width = buffer:text_width(column_style, "M")
      local columns_count = buffer.edge_column + 2
      local columns_width = columns_count * column_width

      local margin_width = buffer.margin_width_n[0]
      local ideal_minimum_width = margin_width + columns_width

      if ui_width >= (ideal_minimum_width * 1.5) then
         minimum_width = ideal_minimum_width
      end
   end

   return minimum_width
end

M.set_main_view = function()
   -- curses doesn't support timeout
   if #_VIEWS > 1 and not CURSES then
      if _VIEWS[1].size == nil then
         timeout(1/60, M.set_main_view)
      else
         local minimum_width = M.minimum_width()
         if _VIEWS[1].size < minimum_width then
            _VIEWS[1].size = minimum_width
         end
      end
   end
end

M.handler = function()
   if #_VIEWS == 2 then
      M.set_main_view()
   end
end

M.connect_event = function()
   events.connect(events.VIEW_NEW, M.handler)
end


return M
