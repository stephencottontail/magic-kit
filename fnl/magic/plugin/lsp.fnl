(module magic.plugin.lsp
  {autoload {nvim aniseed.nvim}})

(defn lsp []
  (let [lspconfig (require :lspconfig)
        signs {:Error :
               :Warn :
               :Hint :󰰁
               :Info :}]
    (nvim.set_keymap :n :gh ":lua vim.lsp.buf.hover()<CR>" {:noremap true})
    (nvim.set_keymap :n :gd ":lua vim.lsp.buf.definition()<CR>" {:noremap true})
    (nvim.set_keymap :n :gD ":lua vim.lsp.buf.declaration()<CR>" {:noremap true})
    (nvim.set_keymap :n "g[" ":lua vim.diagnostic.goto_prev()<CR>" {:noremap true})
    (nvim.set_keymap :n "g]" ":lua vim.diagnostic.goto_next()<CR>" {:noremap true})
    (nvim.set_keymap :n "<leader>lf" ":lua vim.lsp.buf.format({async = true})<CR>" {:noremap true})
    (lspconfig.tsserver.setup {})
    (each [key val (pairs signs)]
      (vim.fn.sign_define
        (.. :DiagnosticSign key)
        {:text val
         :texthl (.. :DiagnosticSign key)
         :numhl (.. :DiagnosticSign key)}))))
