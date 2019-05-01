function min_width()
   local columns_count = buffer.edge_column + 2
   local column_style = _SCINTILLA.constants.STYLE_DEFAULT
   local column_width = buffer:text_width(column_style, "M")
   local columns_width = columns_count * column_width
   local margin_width = buffer.margin_width_n[0]
   return margin_width + columns_width
end

function big_enough()
   return ui.size[1] >= (min_width() * 1.5)
end

function set_main_view_size()
   if _VIEWS[1].size == nil then
      timeout(1/60, set_main_view_size)
   else
      local min_width = min_width()
      if _VIEWS[1].size < min_width then
         _VIEWS[1].size = min_width
      end
   end
end

events.connect(events.VIEW_NEW, function()
   if #_VIEWS > 1 and buffer.edge_column and big_enough() then
      set_main_view_size()
   end
end)
