local M = {}


M.home_path = function()
   return WIN32 and os.getenv("USERPROFILE") or os.getenv("HOME")
end

M.project_path = function()
   return io.get_project_root() or M.home_path()
end

M.current_path = function()
   local path

   if buffer.filename then
      -- from: https://foicica.com/wiki/terminal-here
      path = buffer.filename:match(".+[/\\]")
   else
      path = M.home_path()
   end

   return path
end

M.project_or_current_path = function()
   return io.get_project_root() or M.current_path()
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
      M.project_path(),
      nil,
      M.filter_dialog_options()
   )
end

M.quick_open_home = function()
   io.quick_open(
      M.home_path(),
      nil,
      M.filter_dialog_options()
   )
end

M.terminal = function()
   local terminal = WIN32 and "git-bash.exe" or "st"
   os.spawn(terminal, M.current_path())
end


return M
