-- mouse drag/resize
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- focus
hl.bind("ALT + H", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + L", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + K", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + J", hl.dsp.focus({ direction = "down" }))

-- move/swap
hl.bind("ALT + CONTROL + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("ALT + CONTROL + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("ALT + CONTROL + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("ALT + CONTROL + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("ALT + CONTROL + SPACE", hl.dsp.window.center())

-- resize
hl.bind("ALT + SUPER + H", hl.dsp.window.resize({ x = -64, y = 0, relative = true }), { repeating = true })
hl.bind("ALT + SUPER + J", hl.dsp.window.resize({ x = 0, y = 64, relative = true }), { repeating = true })
hl.bind("ALT + SUPER + K", hl.dsp.window.resize({ x = 0, y = -64, relative = true }), { repeating = true })
hl.bind("ALT + SUPER + L", hl.dsp.window.resize({ x = 64, y = 0, relative = true }), { repeating = true })

-- orientation
-- hl.bind("ALT + S", hl.dsp.layout("togglesplit")) -- dwindle
-- hl.bind("ALT + S", hl.dsp.layout("orientationcycle center left")) -- master
