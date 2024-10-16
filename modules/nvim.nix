{ config, pkgs, ...}:
{
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
	vim.g.mapleader = " "
	require(keymaps)
	'';
    };
  }
