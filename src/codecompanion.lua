return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    { "stevearc/dressing.nvim", opts = {} },
  },
  config = function()
    -- Forcer l'adresse pour toutes les requêtes Ollama sous WSL
    vim.env.OLLAMA_HOST = "http://127.0.0.1:12367"

    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "ollama",
          roles = {
            llm = "AiBarr (Qwen)",
          },
          schema = {
            model = { default = "qwen2.5:latest" },
            num_ctx = { default = 8192 },
          },
          opts = {
            system_prompt = function(opts)
              return
              "Tu es AiBarr, un assistant de programmation IA privé et local, intégré dans Neovim via Ollama. Tu es un expert en développement, concis, direct, et TOUTES tes réponses textuelles doivent être rédigées en français."
            end,
          },
        },
        inline = {
          adapter = "ollama",
          schema = {
            -- model = { default = "deepseek-coder:latest" },
            -- num_ctx = { default = 4096 },
            model = { default = "qwen2.5:latest" },
            num_ctx = { default = 8192 },
          },
          opts = {
            strip_formatting = true,
            prompt_type = "inline",
          },
        },
        agent = {
          adapter = "ollama",
          schema = {
            model = { default = "qwen2.5:latest" },
            num_ctx = { default = 8192 },
          },
        },
      },
      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://127.0.0.1:12367",
            },
          })
        end,
      },
      display = {
        chat = {
          show_token_count = true,
          welcome_message = "Welcome to AiBarr",
          window = {
            position = "left"
          },
        },
      },
      opts = {
        allow_commands = true,
      },
    })

    -- Keymaps
    local map = vim.keymap.set
    map({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle AiBarr Chat" })
    map({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "AiBarr Inline Command" })
    map({ "n", "v" }, "<leader>am", "<cmd>CodeCompanionActions<cr>", { desc = "AiBarr Actions Menu" })

  end,
}
