function relative_path()
   local root = require("open").project_path()
   local path = ""

   if buffer.filename and root then
      local s, e = buffer.filename:find(root, 1, true)

      if s == nil then
         path = buffer.filename
      else
         path = buffer.filename:sub(e+2, #buffer.filename)
      end
   end

   return path
end

function in_view(buffer)
   for i = 1, #_VIEWS do
      if buffer == _VIEWS[i].buffer then
         return true
      end
   end

   return false
end

function unsaved_backgrounds_buffers()
   local str = ""

   for i = 1, #_BUFFERS do
      local buffer = _BUFFERS[i]
      if buffer.modify and not in_view(buffer) then
         str = str .. "!"
      end
   end

   return str
end

function unsaved_foregrounds_buffers()
   local str = ""
   local count = 0

   for i = 1, #_VIEWS do
      local buffer = _VIEWS[i].buffer
      if buffer.modify then
         str = str .. "*"
         count = count + 1
      else
         str = str .. "-"
      end
   end

   return count > 0 and str or ""
end

function unsaved_buffers()
   return unsaved_backgrounds_buffers() .. " " .. unsaved_foregrounds_buffers()
end

events.connect(events.UPDATE_UI, function(updated)
   -- ignore scrolling; see _HOME/core/ui.lua
   if updated and updated & 3 == 0 then
      return
   end

   local position = buffer.current_pos

   local line_count = buffer.line_count
   local line = buffer:line_from_position(position) + 1
   local line_string = string.format("%s %d/%d", _L["Line:"], line, line_count)

   local column = buffer.column[position] + 1
   local column_string = string.format("%s %d", _L["Col:"], column)

   local tabs_prefix = buffer.use_tabs and _L["Tabs:"] or _L["Spaces:"]
   local tabs_string = string.format("%s %d", tabs_prefix, buffer.tab_width)

   local encoding = buffer.encoding or ""
   local eol = buffer.eol_mode == buffer.EOL_CRLF and _L["CRLF"] or _L["LF"]

   local lexer_language = _SCINTILLA.properties.lexer_language[1]
   local lexer = buffer:private_lexer_call(lexer_language):match("^[^/]+")

   local format = CURSES and
      "%s  %s  %s  %s  %s  %s  %s  %s" or
      "%s    %s    %s    %s    %s    %s    %s    %s"

   local text = string.format(
      format,
      unsaved_buffers(),
      relative_path(),
      line_string,
      column_string,
      tabs_string,
      encoding,
      eol,
      lexer
   )

   ui.bufstatusbar_text = text
end)
