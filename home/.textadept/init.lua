-- todo:

-- ctrl+alt+h ignore case
-- when tabs are enabled disable mru on close
-- make sure the active view is a minimum of 80 wide
-- ctrl+h should work with selections, and then deselect
-- find_inc ctrl+h should highlight the content of find_inc input
-- highlight search matches while searching like vim's *
-- in the filtered list pgup and pgdn should work
-- remove the file type from the status bar
-- don't allow a buffer to be put in the background if it's unsaved; prompt to save
   -- or at least notify in the status bar if there's an unsaved buffer in the background
-- show an 'unsaved' indicator on the left of the status bar
   -- one for each view; -*---, hide if ----

-- ctrl+f should use the word under the cursor, it should highlight it (replacing ctrl+h)
   -- and when enter is pressed it should clear highlights and rehighlight the entered search
      -- https://foicica.com/wiki/goto-nearest-occurrence
      -- or: findsetword at: https://foicica.com/wiki/gmc
      -- or: https://github.com/gabdub/ta-tweaks/wiki/goto_nearest-module

-- word counter; https://foicica.com/wiki/stats
-- the first item of a filteredlist should be active at first for selecting and the text box should be active always for text input
-- if a filteredlist is showing "bin/script.py" then "script bin" should find it, not just "bin script"

-- https://github.com/lundmark/textadept_swm
   -- or use findsetword at: https://foicica.com/wiki/gmc
   -- or findall or multiedit at: https://bitbucket.org/SirAlaran/ta-common
   -- Ctrl+Alt+Shift+H

-- ensure non atomic save
-- ensure consistent line endings
-- detect tab width and type from file
-- detect eol type from file

-- https://foicica.com/wiki/export
-- https://foicica.com/wiki/filediff
-- https://bitbucket.org/SirAlaran/ta-common/src

-- https://github.com/editorconfig/editorconfig-textadept
-- https://medium.com/@a_baez/beautify-textadept-87a0c6e384a8
-- https://foicica.com/wiki/textadept-viewer
-- https://medium.com/@a_baez/a-textadept-module-db906f195195
-- https://foicica.com/wiki/line-number-margin
-- https://foicica.com/wiki/distraction-free-mode


require("theme")
require("options")
require("filters").set_filters()

require("modules.zoom_line_numbers")
require("modules.tabs_arg")
