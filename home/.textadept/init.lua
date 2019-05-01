-- todo:

-- ensure non atomic save
-- detect eol type from file
-- ensure consistent line endings
-- detect tab width and type from file

-- in the filteredlists e.g. "bin/script.py" should be found by "script bin" as well as "bin script"
-- the list of a filteredlist should always be active for the up and down arrow keys, the page keys, and enter, and the text box should always be active for all other keys

-- events.FILE_CHANGED reload automatically if no modifications

-- search dialogs (find incremental, etc) should start with the current selection in its input box, or the word under the cursor, or the previous search
   -- highlight the input box content when launching the search dialog (replacing ctrl+h)
      -- when enter is pressed (or ctrl+h), clear highlights and rehighlight the entered text
         -- https://foicica.com/wiki/goto-nearest-occurrence
   -- if getting initial text from selection, deselect after getting it

-- find_inc should not be case sensitive by default
-- ctrl+r should be case sensitive by default, alt to ignore
-- ctrl+alt+h ignore case

-- switch ctrl+h to find/replace and ctrl+r to reload

-- when tabs are enabled disable mru on close
   -- look at events.BUFFER_DELETED and events.BUFFER_BEFORE_SWITCH

-- https://foicica.com/wiki/stats
-- https://foicica.com/wiki/export
-- https://foicica.com/wiki/filediff
-- https://foicica.com/wiki/textadept-viewer
-- https://bitbucket.org/SirAlaran/ta-common/src
-- https://github.com/editorconfig/editorconfig-textadept
-- https://medium.com/@a_baez/beautify-textadept-87a0c6e384a8
-- https://medium.com/@a_baez/a-textadept-module-db906f195195
-- https://foicica.com/wiki/distraction-free-mode
-- https://foicica.com/wiki/line-number-margin


require("theme")
require("options")
require("filters").set_filters()

require("modules.status_bar")
require("modules.zoom_line_numbers")
require("modules.min_width_view")
require("modules.tab_width_arg")
require("modules.tabs_arg")
