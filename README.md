awesome-textbattery
==================

A battery widget for Awesome WM


Installing
----------

    # make install


Uninstalling
------------

    # make uninstall


Using
-----

Import the module

```lua
-- Add this line at the top of your rc.lua
local textbattery = require("textbattery");
```

Create a widget instance (at the start of the Wibox section in rc.lua):

```lua
-- Create the textclock widget
local mytextclock = awful.widget.textclock()
-- Create our textbattery widget
local mytextbattery = awful.widget.textbattery()
```

Add our instance (near the end of the Wibox section in rc.lua):

```lua
-- Add the textbattery widget
right_layout:add(mytextbattery)
right_layout:add(mytextclock)
right_layout:add(mylayoutbox[s])
```
