{pkgs}: {
  channel = "stable-24.05";
  packages = [
    pkgs.jdk17
    pkgs.unzip
    pkgs.python311Packages.pip
    pkgs.zip
    pkgs.sudo
    pkgs.python310
  ];
  idx.extensions = [
    
  ];
  idx.previews = {
    previews = {
      web = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "web-server"
          "--web-hostname"
          "0.0.0.0"
          "--web-port"
          "$PORT"
        ];
        manager = "flutter";
      };
      android = {
        command = [
          "flutter"
          "run"
          "--machine"
          "-d"
          "localhost:5555"
        ];
        manager = "flutter";
      };
    };
  };
}