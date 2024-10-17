{ config, pkgs, home-manager,...}:
{

# Fetch and clone the Neovim config repository
home.file.".config/nvim".source = pkgs.fetchFromGitHub {
	owner = "TypicalUsername-ai";
	repo = "neovim-setup";
	rev = "stable";  # Replace with your branch, tag, or commits
	sha256 = "sha256-3AdwMszJ0quJC2Ovs/UBsqtsWf2WuT67z1DMZ2H8TJs=";
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
