{config}:
{
# Enable user-level systemd
  systemd.user = {
    # Allow user services
    enable = true;

    # Optional: Enable lingering to keep user services running even when not logged in
    lingering = true;
  };

  # Make sure user sessions are properly configured
  systemd = {
    user.sessions = true;
  };
}
