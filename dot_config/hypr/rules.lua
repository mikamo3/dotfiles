hl.window_rule({ match = { class = "Chromium" }, tile = true })

hl.window_rule({ match = { class = "1password" }, workspace = "special", float = true, center = true })
hl.window_rule({ match = { class = "org.gnome.FileRoller" }, float = true, center = true })
hl.window_rule({
    match = { class = "blueman-manager" },
    float = true,
    center = true,
    size = { "monitor_w*0.5", "monitor_h*0.7" },
})
hl.window_rule({ match = { class = "org.remmina.Remmina" }, workspace = "4" })
hl.window_rule({ match = { class = "Code", float = true }, center = true })
hl.window_rule({ match = { class = "Code" }, suppress_event = "maximize", tile = true })

hl.workspace_rule({ workspace = "1", monitor = "desc:LG Electronics LG HDR WQHD", default = true })
hl.workspace_rule({ workspace = "4", monitor = "desc:LG Electronics LG HDR WQHD" })

hl.window_rule({ match = { xwayland = true }, opaque = true })
hl.window_rule({ match = { modal = true }, float = true, center = true })
hl.window_rule({
    match = { class = "xdg-desktop-portal-gtk" },
    float = true,
    center = true,
    size = { "monitor_w*0.5", "monitor_h*0.8" },
})

hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = false })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = false })

hl.config({ xwayland = { force_zero_scaling = true } })
