import collections
import os
import subprocess

from libqtile import bar
from libqtile import command
from libqtile import config
from libqtile import hook
from libqtile import layout
from libqtile import widget



def script_path(name):
   config_path = os.path.abspath(__file__)
   directory = os.path.dirname(config_path)

   return os.path.join(
      directory,
      name
   )


meta = "mod4"
control = "control"
alt = "mod1" # mod1=alt_l; `xmodmap`
shift = "shift"

spawn = True

# keep these in line with:
#    st's and dmenu's config.h
#    dunstrc
#    gtkrc2, gtkrc3 and qtconfig-qt4
#    lightdm-gtk-greeter-settings

normal_font_size = 16
normal_font_name = "Lato"
normal_font_style = "Bold"
normal_font_name_and_style = "{}-{}".format(
   normal_font_name,
   normal_font_style
)

mono_font_size = 14
mono_font_name = "FuraMonoForPowerline Nerd Font"
mono_font_style = "Regular"

# keep this in line with dunstrc; separator_height
border_width = 3

background_colour_with_hash = "#3c3836"
foreground_colour = "fbf1c7"
highlight_colour = "af3a03"
highlight_colour_with_hash = "#{}".format(highlight_colour)
urgent_colour = "9d0006"

widget_padding = 3
widget_defaults = {
   "font": "Lato",
   "fontsize": normal_font_size,
   "foreground": foreground_colour,
   "padding": widget_padding
}

home = os.path.expanduser("~")

screens = [
   config.Screen(
      top=bar.Bar(
         widgets=[
            widget.GroupBox(
               active=foreground_colour,
               inactive=foreground_colour,
               urgent_border=urgent_colour,
               urgent_text=foreground_colour,
               this_current_screen_border=highlight_colour,
               this_screen_border="d65d0e",
               other_current_screen_border="b57614",
               other_screen_border="d79921",

               borderwidth=0,
               disable_drag=True,
               highlight_method="block",
               rounded=False,
               spacing=None,
               urgent_alert_method="block",
               **widget_defaults
            ),
            widget.Spacer(
               length=519
            ),
            widget.Clock(
               format="%A %d/%m %H:%M",
               **widget_defaults
            ),
            widget.Spacer(),
            widget.Systray(
               icon_size=25,
               padding=(widget_padding * 2 if widget_padding else 6)
            )
         ],
         size=31,
         background=background_colour_with_hash
      )
   )
]

groups_base = collections.OrderedDict([
   ("a", {
      "name": "a",
      "exclusive": False,
      "init": True,
      "persist": True,
      "spawn": []
   }),

   ("s", {
      "name": "s",
      "exclusive": False,
      "init": True,
      "persist": True,
      "spawn": [
         "firefox",
         "keepassx"
      ]
   }),

   ("d", {
      "name": "d",
      "exclusive": False,
      "init": True,
      "persist": True,
      "spawn": [
         os.path.expanduser("~/.local/bin/vim-session-st")
      ]
   }),

   ("f", {
      "name": "f",
      "exclusive": False,
      "init": True,
      "persist": True,
      "spawn": [
         "thunderbird"
      ]
   }),

   ("g", {
      "name": "g",
      "exclusive": False,
      "init": True,
      "persist": True,
      "spawn": [
         "quodlibet"
      ]
   })
])

layout_options = {
   "border_normal": background_colour_with_hash,
   "border_focus": highlight_colour_with_hash,
   "border_width": border_width
}

layouts = [
   layout.MonadTall(
      name="normal",
      align=layout.MonadTall._left,
      change_ratio=0.05,
      change_size=10,
      new_at_current=False,
      ratio=0.618,
      single_border_width=0,
      # keep this in line with dunstrc; padding and horizontal_padding
      margin=8,
      **layout_options
   )
]

keys = [
   config.Key(
      [meta, shift],
      "F4",
      command.lazy.spawn(
         "{}/.local/bin/shallow-sleep".format(home)
      ),
      desc="Sleep (shallow)"
   ),

   config.Key(
      [meta],
      "F4",
      command.lazy.spawn(
         "{}/.local/bin/deep-sleep".format(home)
      ),
      desc="Sleep (deep)"
   ),

   config.Key(
      [meta, alt],
      "F4",
      command.lazy.spawn(
         "{}/.local/bin/hibernate".format(home)
      ),
      desc="Hibernate"
   ),

   #config.Key(
   #   [meta, control],
   #   "F3",
   #   command.lazy.spawn(
   #      "{}/.local/bin/shutup".format(home)
   #   ),
   #   desc="Cancel a shutdown"
   #),

   config.Key(
      [meta, control],
      "F4",
      command.lazy.spawn(
         "{}/.local/bin/shutdown".format(home)
      ),
      desc="Shutdown"
   ),

   config.Key(
      [meta, control],
      "F5",
      command.lazy.spawn(
         "{}/.local/bin/restart".format(home)
      ),
      desc="Restart"
   ),

#   config.Key(
#      [meta, alt],
#      "F4",
#      command.lazy.shutdown(),
#      desc="Shutdown the window manager"
#   ),
#
#   config.Key(
#      [meta, alt],
#      "F5",
#      command.lazy.restart(),
#      desc="Restart the window manager"
#   ),

   config.Key(
      [meta],
      "Escape",
      command.lazy.kill(),
      desc="Kill the focused window"
   ),

   config.Key(
      [meta],
      "space",
      command.lazy.spawn(script_path("run.sh")),
      desc="Run a command"
   ),

   config.Key(
      [meta],
      "Return",
      command.lazy.window.toggle_maximize(),
      desc="Toggle maximise"
   ),

   config.Key(
      [meta, alt],
      "Return",
      command.lazy.window.toggle_fullscreen(),
      desc="Toggle fullscreen"
   ),

   config.Key(
      [meta, control],
      "Return",
      command.lazy.layout.normalize(),
      desc="Reset the windows' sizes"
   ),

   config.Key(
      [meta],
      "Prior",
      command.lazy.layout.previous(),
      desc="Move the focus to the previous window"
   ),

   config.Key(
      [meta],
      "Next",
      command.lazy.layout.next(),
      desc="Move the focus to the next window"
   ),

   config.Key(
      [meta, shift],
      "Prior",
      command.lazy.layout.shuffle_up(),
      desc="Move the focused window up the stack"
   ),

   config.Key(
      [meta, shift],
      "Next",
      command.lazy.layout.shuffle_down(),
      desc="Move the focused window down the stack"
   ),

   config.Key(
      [meta, control],
      "Prior",
      command.lazy.layout.grow(),
      desc="Make the focused window bigger"
   ),

   config.Key(
      [meta, control],
      "Next",
      command.lazy.layout.shrink(),
      desc="Make the focused window smaller"
   ),

   config.Key(
      [meta, alt],
      "Prior",
      command.lazy.screen.prev_group(),
      desc="Switch to the previous group"
   ),

   config.Key(
      [meta, alt],
      "Next",
      command.lazy.screen.next_group(),
      desc="Switch to the next group"
   ),

   config.Key(
      [],
      "XF86AudioMute",
      command.lazy.spawn("amixer -q set Master toggle")
   ),

   config.Key(
      [],
      "XF86AudioRaiseVolume",
      command.lazy.spawn("pactl set-sink-volume 0 +5%")
   ),

   config.Key(
      [],
      "XF86AudioLowerVolume",
      command.lazy.spawn("pactl set-sink-volume 0 -5%")
   ),

   config.Key(
      [],
      "XF86MonBrightnessUp",
      command.lazy.spawn("xbacklight -inc 5")
   ),

   config.Key(
      [],
      "XF86MonBrightnessDown",
      command.lazy.spawn("xbacklight -dec 5")
   ),

   config.Key(
      [],
      "Print",
      command.lazy.spawn("{} full".format(script_path("screenshot.sh")))
   ),

   config.Key(
      [alt],
      "Print",
      command.lazy.spawn("{}".format(script_path("screenshot.sh")))
   )

   # config.Key(
      # [],
      # "XF86AudioPlay",
      # command.lazy.spawn("")
   # ),

   # config.Key(
      # [],
      # "XF86AudioPrev",
      # command.lazy.spawn("")
   # ),

   # config.Key(
      # [],
      # "XF86AudioNext",
      # command.lazy.spawn("")
   # ),
]

mouse = [
   config.Drag(
      [meta],
      "Button1",
      command.lazy.window.set_position_floating(),
      start=command.lazy.window.get_position()
   ),

   config.Click(
      [meta],
      "Button2",
      command.lazy.window.bring_to_front()
   ),

   config.Drag(
      [meta],
      "Button3",
      command.lazy.window.set_size_floating(),
      start=command.lazy.window.get_size()
   )
]


groups = []
for index, (key, group_base) in enumerate(groups_base.items()):
   group_name = group_base["name"]

   matches_base = group_base.pop("matches", None)
   if matches_base is not None:
      group_base.update({
         "matches": [config.Match(**match) for match in matches_base]
      })

   if not spawn:
      group_base.pop("spawn", None)

   keys.extend((
      config.Key(
         [meta],
         key,
         command.lazy.screen.toggle_group(group_name),
         desc="Group: {}".format(group_name)
      ),

      config.Key(
         [meta, shift],
         key,
         command.lazy.window.togroup(group_name),
         command.lazy.group[group_name].toscreen(),
         desc=("Move focused window to group" if index == 0 else None)
      )
   ))

   groups.append(
      config.Group(
         position=index,
         **group_base
      )
   )


# docs: http://docs.qtile.org/en/latest/manual/config/#configuration-variables
follow_mouse_focus = False
bring_front_click = False
cursor_warp = False
auto_fullscreen = True
focus_on_window_activation = "urgent"

# from: https://raw.githubusercontent.com/qtile/qtile/develop/libqtile/resources/default_config.py
# docs: http://docs.qtile.org/en/v0.10.4/manual/ref/layouts.html#libqtile.layout.floating.Floating.__init__
floating_layout = layout.Floating(
   float_rules=[
      {"wmclass": "confirm"},
      {"wmclass": "dialog"},
      {"wmclass": "download"},
      {"wmclass": "error"},
      {"wmclass": "file_progress"},
      {"wmclass": "notification"},
      {"wmclass": "splash"},
      {"wmclass": "toolbar"},
      {"wmclass": "confirmreset"}, # gitk
      {"wmclass": "makebranch"}, # gitk
      {"wmclass": "maketag"}, # gitk
      {"wname": "branchdialog"}, # gitk
      {"wname": "pinentry"}, # GPG key password entry
      {"wmclass": "ssh-askpass"}, # ssh-askpass
   ],
   **layout_options
)

# Java wants this for some reason. See:
#    https://raw.githubusercontent.com/qtile/qtile/develop/libqtile/resources/default_config.py
wmname = "LG3D"

# docs: http://docs.qtile.org/en/latest/manual/config/groups.html#example
dgroups_key_binder = None

# undocumented as of 0.10.7
dgroups_app_rules = []
main = None
extentions = []


@hook.subscribe.startup_once
def start():
   subprocess.Popen([script_path("start.sh")])
