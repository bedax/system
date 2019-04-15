local M = {}


M.on_windows = function()
   local path_sep = package.config:sub(1, 1)
   return path_sep == "\\"
end

M.get_home = function()
   return M.on_windows() and os.getenv("USERHOME") or os.getenv("HOME")
end

M.get_project_root = function()
   return io.get_project_root() or M.get_home()
end

M.filter_dialog_width = function()
   local ui_width = ui.size[1]
   local width

   if CURSES then
      width = ui_width - 2
   elseif ui_width < 800 then
      width = 640
   elseif ui_width < 1024 then
      width = 800
   else
      width = ui_width / 100 * 80
   end

   return width
end

M.filter_dialog_options = function()
   return {
      width = M.filter_dialog_width()
   }
end

M.quick_open = function()
   io.quick_open(
      M.get_project_root(),
      nil,
      M.filter_dialog_options()
   )
end

M.quick_open_home = function()
   io.quick_open(
      M.get_home(),
      nil,
      M.filter_dialog_options()
   )
end


return M
