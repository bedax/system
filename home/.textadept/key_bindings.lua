local buffer_menu = textadept.menu.menubar[_L['_Buffer']]

keys["c\t"] = nil
keys["cs\t"] = nil
keys["cpgup"] = buffer_menu[_L['_Previous Buffer']][2]
keys["cpgdn"] = buffer_menu[_L['_Next Buffer']][2]
