return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      eruby = { "erblint" },
      ruby = { "rubocop" },
      markdown = { "markdownlint" },
      yaml = { "yamlfix" },
      javascript = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      json = { "jq" },
    },
  },
}
