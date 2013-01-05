local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local naughty = require("naughty")
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


function level(charge)
	if charge == 0 then
		return 0
	end
	if charge <= 5 then
		return 1
	end
	if charge <= 10 then
		return 2
	end
	if charge <= 15 then
		return 3
	end
	return 4
end



function textbattery.new(timeout)
	local timeout = timeout or 10
	local w = textbox()

	w.level = level(100)

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

		if level(info.charge) < w.level then
			w:warn(info)
			w.level = level(info.charge)
		end
		w:set_markup(text)
	end

	w["warn"] = function(self, info)
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = "Warning: low battery!",
			text = string.format("Battery at %d%%", info.charge)
		})
	end

	w["info"] = function()
		local info = battery:get()
		local title
		if info.adapter then
			title = "Batery charging"
		else
			title = "Batery discharging"
		end
		naughty.notify({
			preset = naughty.config.presets.normal,
			title = title,
			text = (info.time or "unknown") .. " remaining"
		})
	end

	w:buttons(util.table.join(
		button({ }, 1, function()
			w:info()
		end)
	))

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
