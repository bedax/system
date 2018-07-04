if has("win32")
   let opt_directory = "~/local/opt"
   let local_directory = '~/AppData/Local/nvim'
   let config_directory = local_directory
else
   let opt_directory = "~/.local/opt"
   let local_directory = '~/.local/share/nvim'
   let config_directory = '~/.config/nvim'
endif


silent execute 'source '.config_directory.'/plugins.vim'
silent execute 'source '.config_directory.'/plugin_options.vim'
silent execute 'source '.config_directory.'/theme_options.vim'
silent execute 'source '.config_directory.'/options.vim'
silent execute 'source '.config_directory.'/functions.vim'
silent execute 'source '.config_directory.'/bindings.vim'
