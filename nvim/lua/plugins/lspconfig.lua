require('lspconfig').clangd.setup {
    cmd = { "clangd" },
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = require('lspconfig.util').root_pattern('compile_commands.json', 'compile_flags.txt', '.git'),
    single_file_support = true,
}

require('lspconfig').lua_ls.setup {
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
            },
            diagnostics = {
                globals = { 'vim' },
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}


local MY_FQBN = "arduino:avr:nano"
require('lspconfig').arduino_language_server.setup {
    cmd = {
        "arduino-language-server",
        "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
        "-fqbn", MY_FQBN,
        "-I", vim.fn.expand("~/.platformio/packages/framework-arduinoavr/cores/arduino"),
        "-I", vim.fn.expand("~/.platformio/packages/framework-arduinoavr/variants/standard"),
        "-I", vim.fn.expand("~/.platformio/lib")
    }
}
