function handler(width)
   buffer.tab_width = width
end

args.register(
   "-w", "--tab-width", 1, handler,
   "The number of spaces for tabs"
)
