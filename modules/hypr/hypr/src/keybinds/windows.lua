-- mouse drag/resize
hl.bind("ALT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- fun
hl.bind("ALT + Q", hl.dsp.window.close())
hl.bind("ALT + V", hl.dsp.window.float())
hl.bind("ALT + W", hl.dsp.window.fullscreen())

-- focus
hl.bind("ALT + H", hl.dsp.focus({ direction = "left" }))
hl.bind("ALT + L", hl.dsp.focus({ direction = "right" }))
hl.bind("ALT + K", hl.dsp.focus({ direction = "up" }))
hl.bind("ALT + J", hl.dsp.focus({ direction = "down" }))

-- move/swap
hl.bind("ALT + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind("ALT + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind("ALT + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind("ALT + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind("ALT + SHIFT + SPACE", hl.dsp.window.center())

-- resize
hl.bind("ALT + CONTROL + H", hl.dsp.window.resize({ x = -64, y = 0, relative = true }), { repeating = true })
hl.bind("ALT + CONTROL + J", hl.dsp.window.resize({ x = 0, y = 64, relative = true }), { repeating = true })
hl.bind("ALT + CONTROL + K", hl.dsp.window.resize({ x = 0, y = -64, relative = true }), { repeating = true })
hl.bind("ALT + CONTROL + L", hl.dsp.window.resize({ x = 64, y = 0, relative = true }), { repeating = true })

-- orientation
-- hl.bind("ALT + S", hl.dsp.layout("togglesplit")) -- dwindle
hl.bind("ALT + S", hl.dsp.layout("orientationcycle center left")) -- master
