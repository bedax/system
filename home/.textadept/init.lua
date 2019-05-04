-- todo:

-- detect eol type from file
-- ensure consistent line endings
-- detect tab type and width from file

-- events.FILE_CHANGED reload automatically if no modifications

-- search dialogs (find incremental, etc) should start with the current selection in its input box, or the word under the cursor, or the previous search
   -- highlight the input box content when launching the search dialog (replacing ctrl+h)
      -- when enter is pressed (or ctrl+h), clear highlights and rehighlight the entered text
         -- https://foicica.com/wiki/goto-nearest-occurrence
   -- if getting initial text from selection, deselect after getting it

-- ctrl+h case sensitive
-- ctrl+alt+h case insensitive
-- ctrl+f case insensitive
-- ctrl+alt+f case sensitive

-- resize views when resize ui, probably with events.UPDATE_UI
   -- using a variable to keep track of the previous size

-- when tabs are enabled disable mru on close
   -- look at events.BUFFER_DELETED and events.BUFFER_BEFORE_SWITCH

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


require("theme")
require("options")
require("filters").set_filters()

require("modules.status_bar")
require("modules.zoom_line_numbers")
require("modules.min_width_view")
require("modules.tab_width_arg")
require("modules.tabs_arg")
