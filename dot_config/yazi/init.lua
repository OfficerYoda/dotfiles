-- ya pkg add yazi-rs/plugins:no-status
-- from: https://github.com/yazi-rs/plugins/tree/main/no-status.yazi
require("no-status"):setup()

-- ya pkg add yazi-rs/plugins:full-border
-- from: https://github.com/yazi-rs/plugins/tree/main/full-border.yazi
require("full-border"):setup()

-- ya pkg add yazi-rs/plugins:git
-- from: https://github.com/yazi-rs/plugins/tree/main/git.yazi
require("git"):setup({
	-- Order of status signs showing in the linemode
	order = 1500,
})
