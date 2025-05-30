{
  config,
  pkgs,
  home-manager,
  ...
}:
{

  # Fetch and clone the Neovim config repository
  home.file.".config/nvim".source = pkgs.fetchFromGitHub {
    owner = "TypicalUsername-ai";
    repo = "neovim-setup";
    rev = "v1.2.7";
    sha256 = "sha256-pxskfzBpVSxrRDPjwu9Q3PSxpHN0imwAd3F6n5XV3Gk=";
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      alpha-nvim
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
          path = "${pkgs.vimUtils.packDir config.programs.neovim.finalPackage.passthru.packpathDirs}/pack/myNeovimPackages/start",
          patterns = {""}, -- Specify that all of our plugins will use the dev dir. Empty string is a wildcard!
        },
        install = {
          -- Safeguard in case we forget to install a plugin with Nix
          missing = false,
        },
      })
    '';
  };
}
