local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local button = require("awful.button")
local util = require("awful.util")
local capi = { timer = timer }

--- Text battery widget.
-- awful.widget.textbattery
local textbattery = { mt = {} }
local battery = {}


function battery:get()
	local cmd = "acpi -ba"

	local fd = io.popen(cmd)
	local data = fd:read("*all")
	fd:close()

	local info = {}
	info.charge = tonumber(string.match(data, "(%d+)%%") or 0)
	info.time = string.match(data, "(%d%d:%d%d:%d%d)") or nil
	info.adapter = (string.match(data, "(on[-]line)") == "on-line")

	return info
end


function textbattery.new(timeout)
	local timeout = timeout or 10
	local w = textbox()

	w["get"] = battery["get"]

	w["update"] = function()
		local info = battery:get()
		local text
		if info.adapter == true then
			local color = "#AFD700"
			text = string.format("Bat <span color='%s'>%d</span>", color, info.charge)
		else
			local color = "#F53145"
			text = string.format("Bat <span color='%s'>%d</span>", color, info.charge)
		end

		w:set_markup(text)
	end

	local timer = capi.timer { timeout = timeout }
	timer:connect_signal("timeout", function() w:update() end)
	timer:start()
	timer:emit_signal("timeout")
	return w
end


function textbattery.mt:__call(...)
	return textbattery.new(...)
end

return setmetatable(textbattery, textbattery.mt)
