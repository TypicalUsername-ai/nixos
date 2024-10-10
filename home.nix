{
  # Fetch and clone the Neovim config repository
  home.file.".config/nvim".source = builtins.fetchGit {
    url = "https://github.com/TypicalUsername-ai/neovim-setup.git";  # Replace with your repo URL
    ref = "master";  # Replace with your branch, tag, or commit
  };


  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "TypicalUsername-ai";
    userEmail = "mati.domalewski@gmail.com";
    aliases = {
            s = "status";
            c = "checkout";
            b = "branch";
        };
  };

  programs.zoxide = {
      enable = true;
        enableBashIntegration = true;
      };

programs.btop = {
    enable = true;
    };

services.ssh-agent = {
    enable = true;
    };

  # starship - an customizable prompt for any shell
  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      echo Hello, You!
            if [ "$SHLVL" == "1" ]; then
          fastfetch
    fi
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      ll = "eza -alF";
      la = "eza -A";
      l = "eza -CF";
      ls = "eza";
      cat = "bat";
      du = "dust";
      grep = "rg";
      python = "python3";
      dc = "docker compose";
      shellfind = "cat ~/.bash_history | fzf | sh";
      cd = "z";
      cdi = "zi";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
