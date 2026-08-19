hl.config({
    input = {
        kb_layout = "us",
        kb_variant = "",
        kb_model = "",
        kb_options = "",
        kb_rules = "",
        follow_mouse = 1,
        sensitivity = 0.2,
        accel_profile = "adaptive",
        repeat_rate = 50,
        repeat_delay = 400,
        touchpad = { natural_scroll = false },
    },
})

hl.device({ name = "ergo-m575sp-mouse", sensitivity = 0.7 })
hl.device({ name = "logi-m240-mouse", sensitivity = 0.7 })
hl.device({ name = "protoarc-em01-mouse", sensitivity = -0.3 })
