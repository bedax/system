local M = {}


M.handler = function(width)
   require("arguments").override_defaults(function()
      buffer.tab_width = width
   end)
end

M.register_arg = function()
   args.register(
      "-w", "--tab-width", 1, M.handler,
      "The number of spaces for tabs"
   )
end


return M
