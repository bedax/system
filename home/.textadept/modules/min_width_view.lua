local M = {}


M.minimum_width = function()
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

--local setting_main_view_size = false
M.set_main_view = function()
   if #_VIEWS > 1 then
      if _VIEWS[1].size == nil then
         --setting_main_view_size = true
         timeout(1/60, M.set_main_view)
      else
         local minimum_width = M.minimum_width()
         if _VIEWS[1].size < minimum_width then
            _VIEWS[1].size = minimum_width
            --setting_main_view_size = false
         end
      end
   end
end

M.new_handler = function()
   if #_VIEWS == 2 then
      M.set_main_view()
   end
end

M.connect_new_event = function()
   events.connect(events.VIEW_NEW, M.new_handler)
end

--[[ events.UPDATE_UI doesn't trigger when the ui is resized
     remove `setting_main_view_size` when removed this
     rename connect_new_event to connect_event in init.lua and here

local previous_width = ui.size[1]
M.resize_handler = function()
   local current_width = ui.size[1]
   if current_width ~= previous_width and not setting_main_view_size then
      previous_width = current_width
      M.set_main_view()
   end
end

M.connect_resize_event = function()
   events.connect(events.UPDATE_UI, M.resize_handler)
end
]]


return M
