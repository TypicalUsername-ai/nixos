{ config, pkgs, ...}:
{

# Fetch and clone the Neovim config repository
	home.file.".config/nvim".source = builtins.fetchGit {
	url = "https://github.com/TypicalUsername-ai/neovim-setup.git";  # Replace with your repo URL
	ref = "nixos";  # Replace with your branch, tag, or commit
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
      dev = {
        path = "${pkgs.vimUtils.packDir config.home-manager.users.USERNAME.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
      },
      install = {
        -- Safeguard in case we forget to install a plugin with Nix
        missing = false,
      },
    })
      '';
    };
  }
