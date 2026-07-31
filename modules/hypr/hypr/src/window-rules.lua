hl.window_rule({
    name = "suppress-maximize",
    match = {
        class = ".*",
    },
    suppress_event = "maximize",
})

-- hl.window_rule({
--     name = "qalculate-gtk-workspace-rule",
--     match = {
--         class = "qalculate-gtk",
--     },
--     workspace = "special:qalculate-gtk",
--     float = true,
-- })
