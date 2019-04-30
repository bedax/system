function switch_to_last_view()
   local last_view = _VIEWS[#_VIEWS]
   while view ~= last_view do
      ui.goto_view(1)
   end
end

return function()
   local vertical = #_VIEWS % 2 == 1
   switch_to_last_view()
   view:split(vertical)
end
