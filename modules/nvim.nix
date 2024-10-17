{ config, pkgs, home-manager,...}:
{

# Fetch and clone the Neovim config repository
home.file.".config/nvim".source = pkgs.fetchgit {
	url = "https://github.com/TypicalUsername-ai/neovim-setup.git";
	rev = "master";  # Replace with your branch, tag, or commits
	sha256 = "53afec89d0b8547f67e1cc14387f8beba649137e";
  };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      plugins = with pkgs.vimPlugins; [
        conform-nvim
        gitsigns-nvim
        nvim-lspconfig
        lualine-nvim
        nvim-cmp
        nvim-lint
        oil-nvim
        telescope-nvim
        tokyonight-nvim
        nvim-treesitter.withAllGrammars
        trouble-nvim
        which-key-nvim
	lazy-nvim
      ];
      extraLuaConfig = ''
      	require("config.keymaps")
	reuire("config.options")
	vim.g.mapleader = " " -- Need to set leader before lazy for correct keybindings
    	require("lazy").setup({
      		spec = {
        	-- Import plugins from lua/plugins
        	{ import = "plugins" },
      },
      performance = {
        reset_packpath = false,
        rtp = {
            reset = false,
          }
        },
      install = {
        -- Safeguard in case we forget to install a plugin with Nix
        missing = false,
      },
    })
      '';
    };
  }
