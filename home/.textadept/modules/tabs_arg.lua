function handler()
   ui.tabs = true
end

args.register(
   "-t", "--tabs", 0, handler,
   "Opens with the tab bar enabled"
)
