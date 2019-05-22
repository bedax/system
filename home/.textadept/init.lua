-- find.lua

-- make a taf script for filezilla and make a tap script for work
   -- setting the tab-width and session
   -- fix all the ta*s

-- set font size from env

-- detect eol type from file
   -- if inconsitent notify
-- ensure consistent line endings
-- detect tab type and width from file
   -- if tabs and spaces, notify

-- add a --theme parameter and set tap and taf to use different themes
   -- can pass "light" or "dark" to choose the default

-- events.FILE_CHANGED reload automatically if no modifications
   -- notify in status bar

-- when opening a file, if it's already open, switch to it instead of opening a new second buffer
   -- this should be default behaviour; seems like an irregular bug

-- ctrl+b excludes the current buffer but doesn't seem to work with views (?)

-- key command to toggle whitespace display

-- when tabs are not enabled, work in single buffer mode
   -- use ctrl+o to switch buffers, if the current file is only open in this view, close it
   -- ctrl+w wouldn't switch to previously used buffer

-- connect the status bar's update to the after save event

-- when focusing on a view, set its min width
   -- check if this replaces the new view event hook
      -- and if it replaces the size nil check

-- remove ctrl+t; switching modes half way through would confuse things

-- when tabs are enabled disable mru on close
   -- look at events.BUFFER_DELETED and events.BUFFER_BEFORE_SWITCH

-- dialog for renaming/mving current file externally and internally
   -- remove any empty directories in old path's ancestry after the move
   -- ctrl+r

-- cf2 should reset the third split's height, etc

-- some shortcuts don't work in the terminal (e.g. split/unsplit)

-- make a find&replace command using ripgrep and python

-- https://foicica.com/wiki/stats
-- https://foicica.com/wiki/export
-- https://foicica.com/wiki/filediff
-- https://foicica.com/wiki/textadept-viewer
-- https://bitbucket.org/SirAlaran/ta-common/src
-- https://github.com/editorconfig/editorconfig-textadept
-- https://medium.com/@a_baez/beautify-textadept-87a0c6e384a8
-- https://medium.com/@a_baez/a-textadept-module-db906f195195
-- https://foicica.com/wiki/distraction-free-mode

-- searching a single long-line file (e.g. [firefox profile]/extensions.json) does not jump to the next result, presumeably because it's on the same line, but still off screen
-- events.RESIZE_UI for require("minimum_width").connect_resize_event()
-- in the filteredlists e.g. "bin/script.py" should be found by "script bin" as well as "bin script"
-- the list of a filteredlist should always be active for the up and down arrow keys, the page keys, and enter, and the text box should always be active for all other keys

require("theme").set_theme()
require("filters").set_filters()

require("status_bar").connect_event()
require("minimum_width").connect_event()
require("zoom_line_numbers").connect_event()

require("arguments.tab_width").register_arg()
require("arguments.theme").register_arg()
require("arguments.tabs").register_arg()


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
