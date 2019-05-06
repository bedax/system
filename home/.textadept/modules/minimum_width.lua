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

M.set_view = function(first)
   -- curses doesn't support timeout
   if #_VIEWS > 1 and not CURSES then
      if _VIEWS[1].size == nil then
         timeout(1/60, function() M.set_view(first) end)
      else
         local first_size = _VIEWS[1].size
         local primary_minimum_width = M.minimum_width()
         local secondary_maximum_width = ui.size[1] - primary_minimum_width

         if first and first_size < primary_minimum_width then
            _VIEWS[1].size = primary_minimum_width
         elseif not first and first_size > secondary_maximum_width then
            _VIEWS[1].size = secondary_maximum_width
         end
      end
   end
end

M.set_first_view = function()
   M.set_view(true)
end

M.set_second_view = function()
   M.set_view(false)
end

M.handler = function()
   if #_VIEWS == 2 then
      M.set_first_view()
   end
end

M.connect_event = function()
   events.connect(events.VIEW_NEW, M.handler)
end


return M
