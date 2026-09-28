{ pkgs, ... }:
{
  environment = {
    # https://search.nixos.org/packages
    # $ nix search wget
    systemPackages = with pkgs; [
      btop # https://github.com/aristocratos/btop # A monitor of resources
      gitFull # Distributed version control system
      go-task # https://github.com/go-task/task # Task runner / simpler Make alternative written in Go
      kopia # https://github.com/kopia/kopia # Cross-platform backup tool
      mc # https://github.com/MidnightCommander/mc # File Manager and User Shell for the GNU Project, known as Midnight Commander
      nano # Small, user-friendly console text editor
      ncdu # Disk usage analyzer with an ncurses interface
      nh # https://github.com/nix-community/nh # Yet another nix cli helper
      tmux # https://github.com/tmux/tmux/wiki # Terminal multiplexer
      vim # Most popular clone of the VI editor

      # archives
      p7zip # https://github.com/p7zip-project/p7zip # New p7zip fork with additional codecs and improvements
      unzip # Extraction utility for archives compressed in .zip format
      xz # https://github.com/tukaani-project/xz # General-purpose data compression software, successor of LZMA
      zip # Compressor/archiver for creating and modifying zipfiles

      # networking tools
      dnsutils # `dig` + `nslookup`
      mtr # https://github.com/traviscross/mtr # Network diagnostics tool
      netcat-gnu # Utility which reads and writes data across network connections
      wget # Tool for retrieving files using HTTP, HTTPS, and FTP

      # utils
      eza # https://github.com/eza-community/eza # Modern, maintained replacement for ls
      file # Program that shows the type of files
      fzf # https://github.com/junegunn/fzf # Command-line fuzzy finder written in Go
      jq # https://github.com/jqlang/jq # Lightweight and flexible command-line JSON processor
      jqp # https://github.com/noahgorstein/jqp # TUI playground to experiment with jq
      lsof # https://github.com/lsof-org/lsof # LiSt Open Files
      ripgrep # https://github.com/BurntSushi/ripgrep # Recursively searches directories for a regex pattern while respecting your gitignore
      yq-go # https://github.com/mikefarah/yq # Portable command-line YAML processor
      zstd # https://github.com/facebook/zstd # Zstandard real-time compression algorithm
    ];

    # System-level variables
    variables = {
      EDITOR = "vim";
    };
  };
}
