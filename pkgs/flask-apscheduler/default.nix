{
  lib,
  python3Packages,
  fetchFromGitHub,
}:

with python3Packages;

buildPythonPackage rec {
  pname = "flask-apscheduler";
  version = "1.13.1";
  format = "setuptools";

  disabled = python3Packages.pythonOlder "3.8";

  src = fetchFromGitHub {
    owner = "viniciuschiele";
    repo = "flask-apscheduler";
    tag = version;
    hash = "sha256-0gZueUuBBpKGWE6OCJiJL/EEIMqCVc3hgLKwIWFuSZI=";
  };

  propagatedBuildInputs = with python3Packages; [
    setuptools
  ];

  pythonImportsCheck = [ "flask_apscheduler" ];

  dependencies = with python3Packages; [
    flask
    apscheduler
    python-dateutil
  ];

  nativeCheckInputs = [
  ];

  meta = {
    description = "Adds APScheduler support to Flask";
    homepage = "https://github.com/viniciuschiele/flask-apscheduler";
    changelog = "https://github.com/viniciuschiele/flask-apscheduler/releases/tag/${version}";
    license = lib.licenses.apsl20;
    maintainers = with lib.maintainers; [ ivyfanchiang ];
  };
}
