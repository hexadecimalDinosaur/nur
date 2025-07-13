{
  lib,
  python3Packages,
  fetchFromGitHub,
}:

with python3Packages;

buildPythonPackage rec {
  pname = "pyinstxtractor-ng";
  version = "2025.01.06-unstable";

  src = fetchFromGitHub {
    owner = "pyinstxtractor";
    repo = "pyinstxtractor-ng";
    rev = "b733293b0b940a74d007c682143e595cf5cd0511";
    hash = "sha256-ePfu/Hw9WEWRznQq+WgUk9Z31baGDGKjIRpk9iDsAe0=";
  };

  pyproject = true;
  build-system = with python3Packages; [ poetry-core ];
  nativeBuildInputs = with python3Packages; [
    pythonRelaxDepsHook
  ];

  pythonRelaxDeps = [
    "pycryptodome"
  ];
  dependencies = with python3Packages; [
    xdis
    pycryptodome
  ];

  pythonImportsCheck = [ "pyinstxtractor_ng" ];

  meta = {
    description = "Tool to extract the contents of a Pyinstaller generated executable file";
    homepage = "https://github.com/pyinstxtractor/pyinstxtractor-ng/";
    changelog = "https://github.com/pyinstxtractor/pyinstxtractor-ng/releases/tag/${version}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ ivyfanchiang ];
  };
}
