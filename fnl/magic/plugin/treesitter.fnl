(module magic.plugin.treesitter)

(defn treesitter []
  (let [ts (require :nvim-treesitter.configs)]
    (ts.setup {:indent {:enable true}
               :highlight {:enable true
                           :additional_vim_regex_highlighting false}
               :incremental_selection {:enable true}})))
