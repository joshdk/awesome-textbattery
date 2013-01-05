awesome-textbattery
==================

A battery widget for Awesome WM


Installing
----------

    # make install

```lua
-- add this line inside of /usr/share/awesome/lib/awful/widget/init.lua
textbattery = require("awful.widget.textbattery");
```


Uninstalling
------------

    # make uninstall

```lua
-- remove this line from /usr/share/awesome/lib/awful/widget/init.lua
textbattery = require("awful.widget.textbattery");
```

Using
-----

Create a widget instance (at the start of the Wibox section in rc.lua):

```lua
-- Create a textclock widget
mytextclock = awful.widget.textclock()
-- Create a textbattery widget
mytextbattery = awful.widget.textbattery()
```

Add our instance (near the end of the Wibox section in rc.lua):

```lua
-- Add the textbattery widget
right_layout:add(mytextbattery)
right_layout:add(mytextclock)
right_layout:add(mylayoutbox[s])
```
