local M = {}


M.override_defaults = function(fn)
   events.connect(events.UPDATE_UI, function()
      if buffer.set_theme ~= nil then
         fn()
      end
   end)
end


return M
