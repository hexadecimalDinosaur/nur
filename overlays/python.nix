final: prev: {
  pythonPackagesExtensions = prev.pythonPackagesExtensions ++ [
    (pyfinal: pyprev: rec {
      android-unpinner = pyfinal.callPackage ../pkgs/android-unpinner/default.nix { };
      decompyle3 = pyfinal.callPackage ../pkgs/decompyle3/default.nix { inherit xdis; };
      flask-apscheduler = pyfinal.callPackage ../pkgs/flask-apscheduler/default.nix { };
      lib3to6 = pyfinal.callPackage ../pkgs/lib3to6/default.nix { };
      markdown-katex = pyfinal.callPackage ../pkgs/markdown-katex/default.nix { inherit lib3to6; };
      pyinstxtractor-ng = pyfinal.callPackage ../pkgs/pyinstxtractor-ng/default.nix { inherit xdis; };
      xasm = pyfinal.callPackage ../pkgs/xasm/default.nix { inherit xdis x-python; };
      xdis = pyprev.xdis.overrideAttrs (final: old: {
        patches = [
          ../pkgs/xdis/xdis.patch
        ];
      });
      x-python = pyfinal.callPackage ../pkgs/x-python/default.nix { inherit xdis; };
    })
  ];
}
