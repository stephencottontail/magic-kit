(module magic.plugin.treesitter)

(defn- link-highlight [group highlight]
  "Links Treesitter capture group GROUP to Neovim highlight HIGHLIGHT"
  (vim.api.nvim_set_hl 0
                       group
                       {:link highlight})) 

(defn treesitter []
  (let [ts (require :nvim-treesitter.configs)]
    (link-highlight "@include.javascript" "Normal")
    (link-highlight "@punctuation.bracket.javascript" "Normal")
    (link-highlight "@punctuation.delimiter.javascript" "Normal")
    (link-highlight "@tag.attribute.javascript" "Normal")
    (link-highlight "@tag.delimiter.javascript" "Normal")
    (link-highlight "@type.javascript" "Function")
    (link-highlight "@tag.javascript" "Function")
    (link-highlight "@constructor.javascript" "Function")
    (ts.setup {:indent {:enable true}
               :highlight {:enable true
                           :additional_vim_regex_highlighting false}
               :incremental_selection {:enable true}})))
