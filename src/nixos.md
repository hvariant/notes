# NixOS

## maintenance

upgrade:
```
$ nix-channel --add https://nixos.org/channels/nixos-20.09 nixos
$ nix-channel --update
$ nixos-rebuild --upgrade switch
```

clean up old generations:
```
$ sudo nix-collect-garbage -d
```

## shell.nix snippets

### choosing channels

system default channel:
```
with import <nixpkgs> {};
```

alternatively:

```
let
  pkgs = import <nixpkgs> {};

# ...
```

choosing a specific branch/channel:
```
let
  nixpkgs = import (builtins.fetchGit {
    name = "nixos-19.09";
    url = https://github.com/nixos/nixpkgs/;
    ref = "nixos-19.09";
  }) {};

# ...
```

### creating an environment

making derivation:
```
let
  nixpkgs = import <nixpkgs> {};
in
  nixpkgs.stdenv.mkDerivation {
    name = "derivation";
    buildInputs = [ nixpkgs.ghc ];
  }
```

making shell:
```
let
  nixpkgs = import <nixpkgs> {};
in
  nixpkgs.mkShell {
    name = "shell-hook";

    buildInputs = [
      nixpkgs.python3
    ];

    shellHook = ''
      python
    '';
  }
```

### haskell

see [this guide](https://github.com/Gabriel439/haskell-nix).

### how to build traditional unix directory structure

See [this post](https://sid-kap.github.io/posts/2018-03-08-nix-pipenv.html) for reference.

default.nix:
```
let

  nixpkgs = import <nixpkgs> {};

  manyLinuxFile =
    nixpkgs.writeTextDir "_manylinux.py"
      ''
        print("in _manylinux.py")
        manylinux1_compatible = True
      '';

in

  nixpkgs.buildFHSUserEnv {
    name = "python-manylinux";
    targetPkgs = pkgs: with pkgs; [
      python3
      pipenv
      which
      gcc
      binutils

      # All the C libraries that a manylinux_1 wheel might depend on:
      ncurses
      xorg.libX11
      xorg.libXext
      xorg.libXrender
      xorg.libICE
      xorg.libSM
      glib
    ];

    profile = ''
      export PYTHONPATH=${manyLinuxFile.out}:/usr/lib/python3.7/site-packages
    '';

    runScript = "bash";
  }
```

shell.nix:
```
let

  nixpkgs = import <nixpkgs> {};

in

  nixpkgs.mkShell {
    name = "python-manylinux";

    shellHook = ''
      if [ ! -f result/bin/python-manylinux ]; then
        echo "please run nix-build"
        exit 1
      fi
      $PWD/result/bin/python-manylinux
    '';
  }
```

example usage:
```
nix-build
nix-shell
```

### changing LD_LIBRARY_PATH

```
with import <nixpkgs> {};

stdenv.mkDerivation rec {
  name = "dev";
  buildInputs = [
    openssl
  ];
  LD_LIBRARY_PATH="${stdenv.cc.cc.lib}/lib64:$LD_LIBRARY_PATH";
}
```
