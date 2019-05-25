local M = {}


M.default_filter = {
   -- cargo
   "!/target/release$",
   "!/target/debug$",

   -- npm
   "!/node_modules$",

   -- vcs
   "!/%.git/objects$",
   "!/%.hg$",

   -- wordpress stuff
   "!/wp-admin$",
   "!/wp-content/plugins$",
   "!/wp-content/themes/twenty.+$",
   "!/wp-includes$",

   -- windows stuff
   "!/desktop.ini$",
   "!/ntuser.ini$",
   "!/NTUSER.DAT",
   "!/ntuser.dat",

   -- other directories
   "!/%.cache$",

   -- file types
   "!.7z",
   "!.a",
   "!.bmp",
   "!.bz2",
   "!.dll",
   "!.exe",
   "!.flac",
   "!.gif",
   "!.gz",
   "!.jpeg",
   "!.jpg",
   "!.jpg",
   "!.lock",
   "!.m4a",
   "!.mkv",
   "!.mp3",
   "!.mp4",
   "!.o",
   "!.ogg",
   "!.ogv",
   "!.otf",
   "!.pdf",
   "!.png",
   "!.so",
   "!.tar",
   "!.tgz",
   "!.tif",
   "!.tiff",
   "!.ttf",
   "!.webm",
   "!.woff",
   "!.xz",
   "!.zip"
}


M.home_filter = function()
   local home = require("open").home_path()
   local filter = { "!^" .. home .. "/%..*/" }

   if WIN32 then
      table.insert(filter, "!^" .. home .. "/AppData")
      table.insert(filter, "!^" .. home .. "/Favorites")
      table.insert(filter, "!^" .. home .. "/IntelGraphicsProfile")
      table.insert(filter, "!^" .. home .. "/Links")
      table.insert(filter, "!^" .. home .. "/MicrosoftEdgeBackups")
      table.insert(filter, "!^" .. home .. "/Searches")
   else
      table.insert(filter, "!^" .. home .. "/games")
      table.insert(filter, "!^" .. home .. "/music")
   end

   for i=1, #M.default_filter do
      table.insert(filter, M.default_filter[i])
   end

   return filter
end


M.set_filters = function()
   local home = require("open").home_path()
   lfs.default_filter = M.default_filter
   io.quick_open_filters[home] = M.home_filter()
end


return M
