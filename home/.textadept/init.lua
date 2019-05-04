-- detect eol type from file
-- ensure consistent line endings
-- detect tab type and width from file

-- events.FILE_CHANGED reload automatically if no modifications

-- when tabs are enabled disable mru on close
   -- look at events.BUFFER_DELETED and events.BUFFER_BEFORE_SWITCH

-- dialog for renaming/mving current file externally and internally
   -- remove any empty directories in old path's ancestry after the move
   -- ctrl+r

-- events.RESIZE_UI for require("min_width_view").connect_resize_event()
-- in the filteredlists e.g. "bin/script.py" should be found by "script bin" as well as "bin script"
-- the list of a filteredlist should always be active for the up and down arrow keys, the page keys, and enter, and the text box should always be active for all other keys

-- https://foicica.com/wiki/stats
-- https://foicica.com/wiki/export
-- https://foicica.com/wiki/filediff
-- https://foicica.com/wiki/textadept-viewer
-- https://bitbucket.org/SirAlaran/ta-common/src
-- https://github.com/editorconfig/editorconfig-textadept
-- https://medium.com/@a_baez/beautify-textadept-87a0c6e384a8
-- https://medium.com/@a_baez/a-textadept-module-db906f195195
-- https://foicica.com/wiki/distraction-free-mode

require("theme").set_theme()
require("filters").set_filters()

require("status_bar").connect_event()
require("zoom_line_numbers").connect_event()
require("min_width_view").connect_new_event()
require("tab_width_arg").register_arg()
require("tabs_arg").register_arg()


ui.tabs = false

buffer.tab_width = 3
buffer.use_tabs = false

buffer.wrap_mode = buffer.WRAP_WORD
buffer.wrap_indent_mode = buffer.WRAPINDENT_INDENT
buffer.wrap_visual_flags = buffer.WRAPVISUALFLAG_MARGIN
buffer.wrap_visual_flags_location = buffer.WRAPVISUALFLAGLOC_DEFAULT

buffer.indentation_guides = buffer.IV_NONE
buffer.tab_draw_mode = buffer.TD_LONGARROW
buffer.caret_style = buffer.CARETSTYLE_BLOCK
buffer.caret_period = 0

buffer.edge_mode = buffer.EDGE_LINE
buffer.edge_column = 79

buffer.v_scroll_bar = false
buffer.h_scroll_bar = false

-- disable code folding
buffer.margin_width_n[2] = 0

io.quick_open_max = 1024 * 128

textadept.editing.auto_pairs = nil
textadept.editing.typeover_chars = nil
textadept.editing.strip_trailing_spaces = true

textadept.session.max_recent_files = 16
