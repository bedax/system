local M = {}


M.default_filter = {
   -- cargo
   "!/target/release$",
   "!/target/debug$",

   -- npm
   "!/node_modules$",

   -- vcs
   "!/%.git/objects$",
   "!/%.bzr$",
   "!/%.svn$",
   "!/%.hg$",

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
   local home = require("rooted_open").get_home()
   local filter = { "!^" .. home .. "/%." }

   if not require("rooted_open").on_windows() then
      table.insert(filter, "!^" .. home .. "/music")
      table.insert(filter, "!^" .. home .. "/previous")
      table.insert(filter, "!^" .. home .. "/www/[^/\\]+/")
   end

   for i=1, #M.default_filter do
      table.insert(filter, M.default_filter[i])
   end

   return filter
end


M.set_filters = function()
   local home = require("rooted_open").get_home()
   lfs.default_filter = M.default_filter
   io.quick_open_filters[home] = M.home_filter()
end


return M
