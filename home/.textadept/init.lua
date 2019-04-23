-- todo:

-- ensure non atomic save
-- ensure consistent line endings
-- detect tab width and type from file
-- detect eol type from file

-- in the filteredlists e.g. "bin/script.py" should be found by "script bin" as well as "bin script"
-- the list of a filteredlist should always be active for the up and down arrow keys, the page keys, and enter, and the text box should always be active for all other keys

-- search dialogs (find incremental, etc) should start with the current selection or the word under the cursor in its input box
   -- highlight the input box content when launching the search dialog (replacing ctrl+h)
      -- when enter is pressed (or ctrl+h), clear highlights and rehighlight the entered text
         -- https://foicica.com/wiki/goto-nearest-occurrence

-- show an 'unsaved' indicator on the left of the status bar
   -- notify in red in the status bar if there's an unsaved buffer in the background
   -- one for each view, hide if all saved

-- ctrl+alt+h ignore case
-- ctrl+h should work with selections, and then deselect
-- make sure the active view is always a minimum of [80] wide
-- when tabs are enabled disable mru on close

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

require("modules.zoom_line_numbers")
require("modules.tabs_arg")
