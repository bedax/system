-- from: https://foicica.com/wiki/adjust-line-number-margin-on-zoom

events.connect('SCN', function(n)
  if n.code == _SCINTILLA.constants.SCN_ZOOM then
    local buffer = buffer
    local width = #(buffer.line_count..'')
    width = width > 4 and width or 4
    buffer.margin_width_n[0] = 4 + width * buffer:text_width(_SCINTILLA.constants.STYLE_LINENUMBER, '9')
  end
end)
