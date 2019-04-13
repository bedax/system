ui.tabs = true
buffer.use_tabs = false
buffer.tab_width = 3
textadept.editing.strip_trailing_spaces = true
textadept.editing.auto_pairs = nil
textadept.editing.typeover_chars = nil
buffer.wrap_mode = 1

local buffer_menu = textadept.menu.menubar[_L['_Buffer']]

keys["c\t"] = nil
keys["cs\t"] = nil
keys["cpgup"] = buffer_menu[_L['_Previous Buffer']][2]
keys["cpgdn"] = buffer_menu[_L['_Next Buffer']][2]
