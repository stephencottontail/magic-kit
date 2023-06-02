(module magic.init
  {autoload {plugin magic.plugin
             nvim aniseed.nvim}})

;;; Introduction

;; Aniseed compiles this (and all other Fennel files under fnl) into the lua
;; directory. The init.lua file is configured to load this file when ready.

;; We'll use modules, macros and functions to define our configuration and
;; required plugins. We can use Aniseed to evaluate code as we edit it or just
;; restart Neovim.

;; You can learn all about Conjure and how to evaluate things by executing
;; :ConjureSchool in your Neovim. This will launch an interactive tutorial.


;;; Generic configuration

(set nvim.o.termguicolors true)
(set nvim.o.mouse "a")
(set nvim.o.updatetime 500)
(set nvim.o.timeoutlen 500)
(set nvim.o.sessionoptions "blank,curdir,folds,help,tabpages,winsize")
(set nvim.o.inccommand :split)

(nvim.ex.set :spell)
(nvim.ex.set :list)


;;; Mappings

(set nvim.g.mapleader " ")
(set nvim.g.maplocalleader ",")


;;; Plugins

;; Run script/sync.sh to update, install and clean your plugins.
(plugin.use
  :MaxMEllon/vim-jsx-pretty {:ft ["javascriptreact" "typescriptreact"]}
  :Olical/aniseed {:lazy false}
  :Olical/conjure {:ft ["clojure" "fennel"]}
  :neovim/nvim-lspconfig {:ft [:javascriptreact :typescriptreact]
                          :config (fn []
                                    (let [lsp (require :lspconfig)]
                                      (lsp.tsserver.setup {})
                                      (nvim.set_keymap :n :gh ":lua vim.lsp.buf.hover()<cr>" {})
                                      (nvim.set_keymap :n :gd ":lua vim.lsp.buf.definition()<cr>" {})
                                      (nvim.set_keymap :n :gD ":lua vim.lsp.buf.declaration()<cr>" {})))}
  :stephencottontail/nvim-colors {:lazy false
                                  :url "git@github.com:stephencottontail/nvim-colors.git"
                                  :config (fn [] (nvim.ex.colorscheme :tokyonight))}
  )

