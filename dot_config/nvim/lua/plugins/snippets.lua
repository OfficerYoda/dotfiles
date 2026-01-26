return {
  "L3MON4D3/LuaSnip",
  opts = function()
    local ls = require("luasnip")
    local f = ls.function_node
    local postfix = require("luasnip.extras.postfix").postfix
    local rep = require("luasnip.extras").rep -- Fixes the "extras" nil error

    ls.add_snippets("java", {
      -- Postfix: type 'myVar.soutv' then press Tab
      postfix(".soutv", {
        f(function(_, parent)
          local var = parent.snippet.env.POSTFIX_MATCH
          return 'System.out.println("' .. var .. ' = " + ' .. var .. ");"
        end, {}),
      }),
      -- Standard: type 'soutv' then press Tab
      ls.s("soutv", {
        ls.t('System.out.println("'),
        ls.i(1, "variable"),
        ls.t('" + '),
        rep(1),
        ls.t(");"),
      }),
    })
  end,
}
