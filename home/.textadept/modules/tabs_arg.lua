local M = {}


M.handler = function()
   ui.tabs = true
end

M.register_arg = function()
   args.register(
      "-t", "--tabs", 0, M.handler,
      "Opens with the tab bar enabled"
   )
end


return M
