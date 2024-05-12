{ pkgs, lib, config, ... }: {
  options = {
    ssh.enable = lib.mkEnableOption "enable ssh";
  };

  config = lib.mkIf config.ssh.enable {
    services.ssh-agent.enable = true;
    programs.ssh = {
      enable = true;
      addKeysToAgent = "ask";
      matchBlocks = {
        "github.com github" = {
          hostname = "github.com";
          user = "git";
          identityFile = "/home/joel/.ssh/github_id_ed25519";
        };
      };
    };
  };
}