{ pkgs, home-manager, ... }:
{

  # Fetch and clone the Neovim config repository
  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "TypicalUsername-ai";
    repo = "neovim-setup";
    rev = "v1.2.3";
    sha256 = "sha256-JY/WdTlkmtoEbonL6T8nMQUuQZGSrSmLUpRWUtLbbqE=";
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
      	require("config.options")
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
