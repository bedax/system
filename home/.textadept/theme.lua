if not CURSES then
   buffer:set_theme(
      "base16-ashes-dark", {
         font = WIN32 and "Fira Mono" or "Fira Mono Medium",
         fontsize = 11
      }
   )
end
