return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory", "DiffviewToggleFiles" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Git diff (working tree)" },
		{ "<leader>gh", "<cmd>DiffviewFileHistory %<cr>", desc = "Git history (current file)" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "Git history (whole repo)" },
		{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Git diff close" },
	},
	opts = {
		enhanced_diff_hl = true,
	},
}
