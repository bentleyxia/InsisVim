local common = require("insis.lsp.common-config")

local opts = {
  capabilities = common.capabilities,
  flags = common.flags,
  cmd = {
    "clangd",
    "--background-index",
    "--pch-storage=memory",
    "--clang-tidy",
    "--suggest-missing-includes",
    "--cross-file-rename",
    "--completion-style=detailed",
  },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
  on_attach = function(client, bufnr)
    client.resolved_capabilities.document_formatting = false
    client.resolved_capabilities.document_range_formatting = false
    local function buf_set_keymap(...)
      ---@diagnostic disable-next-line: missing-parameter
      vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    require("keybindings").mapLSP(buf_set_keymap)
    common.keyAttach(bufnr)
    -- common.disableFormat(client)
  end,
}

return {
  on_setup = function(server)
    server.setup(opts)
  end,
}
