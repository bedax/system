-- todo:
-- long line marker

-- don't switch to mru on tab close
-- detect tab width and type from file
-- detect eol type from file
-- strip new lines at end
-- ensure consistent line endings
-- ensure non atomic save
-- highlight search matches while searching

-- use current word for find; https://foicica.com/wiki/goto-nearest-occurrence
   -- or use findsetword at: https://foicica.com/wiki/gmc

-- force new line at end; https://foicica.com/wiki/final-newline
-- word counter; https://foicica.com/wiki/stats

-- https://github.com/lundmark/textadept_swm
   -- or use findsetword at: https://foicica.com/wiki/gmc
   -- or findall or multiedit at: https://bitbucket.org/SirAlaran/ta-common

-- https://foicica.com/wiki/terminal-here
-- https://foicica.com/wiki/export
-- https://foicica.com/wiki/filediff
-- https://bitbucket.org/SirAlaran/ta-common/src
-- https://foicica.com/wiki/control-tab-mru
   -- or, more limited: https://foicica.com/wiki/previous-buffer-z-order

-- areturn - focus view
-- creturn - maximise view
-- co - rooted file open
-- ct - new tab
-- cn - new split
-- cv - new vsplit
-- ctrl-f find inc
-- ctrl-r find replace
-- alt-arrows (pgup pgdown) move between views

-- https://medium.com/@a_baez/beautify-textadept-87a0c6e384a8
-- https://foicica.com/wiki/textadept-viewer
-- https://medium.com/@a_baez/a-textadept-module-db906f195195


ui.tabs = true

buffer.tab_width = 3
buffer.use_tabs = false

buffer.wrap_mode = buffer.WRAP_WORD
buffer.wrap_indent_mode = buffer.WRAPINDENT_INDENT
buffer.wrap_visual_flags = buffer.WRAPVISUALFLAG_MARGIN
buffer.wrap_visual_flags_location = buffer.WRAPVISUALFLAGLOC_DEFAULT

buffer.edge_mode = buffer.EDGE_LINE
buffer.edge_column = 79

buffer.tab_draw_mode = buffer.TD_LONGARROW

-- disable code folding
buffer.margin_width_n[2] = 0

io.quick_open_max = 1024

textadept.editing.auto_pairs = nil
textadept.editing.typeover_chars = nil
textadept.editing.strip_trailing_spaces = true

textadept.session.max_recent_files = 16


if not CURSES then
   buffer:set_theme(
      "base16-ashes-dark",
      { font = "Fira Mono", fontsize = 12 }
   )
end


local buffer_menu = textadept.menu.menubar[_L['_Buffer']]

keys["c\t"] = nil
keys["cs\t"] = nil
keys["cpgup"] = buffer_menu[_L['_Previous Buffer']][2]
keys["cpgdn"] = buffer_menu[_L['_Next Buffer']][2]
