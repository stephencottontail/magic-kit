(module magic.plugin
  {autoload {a aniseed.core
             nvim aniseed.nvim
             lazy lazy}})

(defn- safe-require-plugin-config [name]
  "Safely require a module under the magic.plugin.* prefix. Will catch errors
  and print them while continuing execution, allowing other plugins to load
  even if one configuration module is broken."
  (let [(ok? val-or-err) (pcall require (.. "magic.plugin." name))]
    (when (not ok?)
      (print (.. "Plugin config error: " val-or-err)))))

(defn req [name]
  "A shortcut to building a require string for your plugin
  configuration. Intended for use with lazy.nvim's config or setup
  configuration options. Will prefix the name with `magic.plugin.`
  before requiring."
  (.. "require('magic.plugin." name "')"))

(defn use [...]
  "Iterates through the arguments as pairs and calls lazy.nvim's use function
  for each of them. Works around Fennel not liking mixed associative and
  sequential tables as well.

  This is just a helper / syntax sugar function to make interacting with
  lazy.nvim a little more concise."
  (let [args [...]
        plugins {}]
    (for [i 1 (a.count args) 2]
      (let [name (. args i)
            opts (. args (+ i 1))]
        (-?> (. opts :mod) (safe-require-plugin-config))
        (table.insert plugins (a.assoc opts 1 name))))
    (lazy.setup plugins {:root (.. (nvim.fn.stdpath "config") "/lazy") :defaults {:lazy true}})))
