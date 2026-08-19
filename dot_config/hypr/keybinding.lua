local terminal = "ghostty"
local file_manager = "nautilus"
local menu = "fuzzel"
local main_mod = "SUPER"

hl.bind(main_mod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(main_mod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(main_mod .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(main_mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(main_mod .. " + F", hl.dsp.window.fullscreen())
hl.bind(main_mod .. " + N", hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(main_mod .. " + Z", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | wl-copy"))
hl.bind(main_mod .. " + SHIFT + Z", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | swappy -f -"))
hl.bind(main_mod .. " + S", hl.dsp.workspace.toggle_special(""))
hl.bind(main_mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special" }))
hl.bind(main_mod .. " + C", hl.dsp.exec_cmd("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy"))
hl.bind(main_mod .. " + V", hl.dsp.exec_cmd("~/.local/bin/fuzzel-vscode"))
hl.bind(main_mod .. " + SHIFT + P", hl.dsp.exec_cmd("~/.local/bin/fuzzel-power"))

hl.bind(main_mod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(main_mod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(main_mod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(main_mod .. " + j", hl.dsp.focus({ direction = "d" }))
hl.bind(main_mod .. " + SHIFT + h", hl.dsp.window.move({ direction = "l" }))
hl.bind(main_mod .. " + SHIFT + l", hl.dsp.window.move({ direction = "r" }))
hl.bind(main_mod .. " + SHIFT + k", hl.dsp.window.move({ direction = "u" }))
hl.bind(main_mod .. " + SHIFT + j", hl.dsp.window.move({ direction = "d" }))

hl.bind(main_mod .. " + r", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    hl.bind("h", hl.dsp.window.resize({ x = -120, y = 0, relative = true }), { repeating = true })
    hl.bind("l", hl.dsp.window.resize({ x = 120, y = 0, relative = true }), { repeating = true })
    hl.bind("k", hl.dsp.window.resize({ x = 0, y = -120, relative = true }), { repeating = true })
    hl.bind("j", hl.dsp.window.resize({ x = 0, y = 120, relative = true }), { repeating = true })
    hl.bind("escape", hl.dsp.submap("reset"))
end)

for i = 1, 10 do
    local key = i % 10
    hl.bind(main_mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(main_mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(main_mod .. " + SHIFT + r", hl.dsp.force_renderer_reload())
hl.bind(main_mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main_mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind(main_mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(main_mod .. " + CTRL + h", hl.dsp.window.move({ monitor = "l" }))
hl.bind(main_mod .. " + CTRL + l", hl.dsp.window.move({ monitor = "r" }))
hl.bind(main_mod .. " + CTRL + k", hl.dsp.window.move({ monitor = "u" }))
hl.bind(main_mod .. " + CTRL + j", hl.dsp.window.move({ monitor = "d" }))
