local M = {}


M.handler = function(width)
   buffer.tab_width = width
end

M.register_arg = function()
   args.register(
      "-w", "--tab-width", 1, M.handler,
      "The number of spaces for tabs"
   )
end


return M
