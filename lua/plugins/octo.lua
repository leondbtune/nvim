return {
	"pwntester/octo.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Octo",
	keys = {
		{ "<leader>gp", "<cmd>Octo pr list<cr>", desc = "GitHub: list PRs" },
		{ "<leader>gP", "<cmd>Octo pr<cr>", desc = "GitHub: PR for current branch" },
		{ "<leader>gi", "<cmd>Octo issue list<cr>", desc = "GitHub: list issues" },
		{ "<leader>go", "<cmd>Octo<cr>", desc = "GitHub: Octo picker" },
	},
	opts = {
		enable_builtin = true,
		default_merge_method = "squash",
	},
}
