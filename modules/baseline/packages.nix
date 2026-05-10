{ pkgs, ... }:
{
  environment = {
    # https://search.nixos.org/packages
    # $ nix search wget
    systemPackages = with pkgs; [
      btop # https://github.com/aristocratos/btop # A monitor of resources
      file # Program that shows the type of files
      gitFull # Distributed version control system
      go-task # https://github.com/go-task/task # Task runner / simpler Make alternative written in Go
      kopia # https://github.com/kopia/kopia # Cross-platform backup tool
      lsof # https://github.com/lsof-org/lsof # LiSt Open Files
      mc # https://github.com/MidnightCommander/mc # File Manager and User Shell for the GNU Project, known as Midnight Commander
      nano # Small, user-friendly console text editor
      ncdu # Disk usage analyzer with an ncurses interface
      netcat-gnu # Utility which reads and writes data across network connections
      nh # https://github.com/nix-community/nh # Yet another nix cli helper
      ripgrep # https://github.com/BurntSushi/ripgrep # Recursively searches directories for a regex pattern while respecting your gitignore
      tmux # https://github.com/tmux/tmux/wiki # Terminal multiplexer
      vim # Most popular clone of the VI editor
      wget # Tool for retrieving files using HTTP, HTTPS, and FTP
    ];

    # System-level variables
    variables = {
      EDITOR = "vim";
    };
  };
}
