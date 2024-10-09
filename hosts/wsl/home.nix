{
  # Fetch and clone the Neovim config repository
  home.file.".config/nvim".source = builtins.fetchGit {
    url = "https://github.com/TypicalUsername-ai/neovim-setup.git";  # Replace with your repo URL
    rev = "refs/heads/main";  # Replace with your branch, tag, or commit
  };

}
