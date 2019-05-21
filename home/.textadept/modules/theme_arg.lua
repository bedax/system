local M = {}


M.handler = function(name)
   events.connect(events.BUFFER_NEW, function()
      if name == "light" or name == "dark" then
         require("theme").set_theme_shade(name)
      else
         require("theme").set_theme_name(name)
      end
   end)
end

M.register_arg = function()
   args.register(
      "-c", "--theme", 1, M.handler,
      "The name of the theme file"
   )
end


return M
