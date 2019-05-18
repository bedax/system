local M = {}


M.set_theme_name = function(name)
   if not CURSES then
      buffer:set_theme(name, {
         font = WIN32 and "Fira Mono" or "Fira Mono Medium",
         fontsize = 14
      })
   end
end

M.set_theme_shade = function(shade)
   M.set_theme_name("base16-ashes-"..shade)
end

M.set_theme = function()
   M.set_theme_shade("dark")
end


return M
