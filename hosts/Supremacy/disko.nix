{inputs, ...}: {
  imports = [
    inputs.disko.nixosModules.disko
  ];
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/nvme2n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              start = "1M";
              end = "1G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountOptions = [ "umask=0077" ];
                mountpoint = "/boot";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "@root" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/";
                  };
                  "@home" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/home";
                  };
                  "@nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  #"@persist" = {
                  #  mountOptions = [ "compress=zstd" "noatime" ];
                  #  mountpoint = "/persist";
                  #};
                  "@log" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/var/log";
                  };
                  "@swap" = {
                    mountpoint = "/.swapvol";
                    swap = {
                      swapfile.size = "32G";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
    #nodev = {
    #  "/" = {
    #    fsType = "tmpfs";
    #    mountOptions = [ "defaults" "size=25%" "mode=755" ];
    #  };
    #};
  };
}
