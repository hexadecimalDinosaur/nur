{
  lib,
  python3Packages,
  fetchFromGitHub,
}:

with python3Packages;

buildPythonPackage {
  pname = "android-unpinner";
  version = "202107.1047";

  src = fetchFromGitHub {
    owner = "mitmproxy";
    repo = "android-unpinner";
    rev = "f5ced37a9e40740d160faef9491121ba2df48ffe";
    hash = "sha256-ZGUj5d47rEovpz7Wz25670OPaxT1mA2st7+L6Nz1G3w=";
  };

  doCheck = false;

  dependencies = with python3Packages; [
    rich-click
  ];

  pyproject = true;
  build-system = with python3Packages; [
    setuptools
  ];
}
