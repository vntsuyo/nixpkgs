{
  lib,
  buildPythonPackage,
  fetchPypi,
  pytestCheckHook,
  six,
  paste,
  setuptools,
  pastedeploy,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "pastescript";
  version = "3.7.0";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    hash = "sha256-U28CjftuUynGezIpnhyTA/kSZOSXk8xpFusKc+tKJSE=";
  };

  build-system = [ setuptools ];

  propagatedBuildInputs = [
    paste
    pastedeploy
    six
  ];

  # test suite seems to unset PYTHONPATH
  doCheck = false;

  nativeCheckInputs = [ pytestCheckHook ];

  disabledTestPaths = [ "appsetup/testfiles" ];

  pythonImportsCheck = [
    "paste.script"
    "paste.deploy"
    "paste.util"
  ];

  meta = with lib; {
    description = "Pluggable command-line frontend, including commands to setup package file layouts";
    mainProgram = "paster";
    homepage = "https://github.com/cdent/pastescript/";
    license = licenses.mit;
    maintainers = [ ];
  };
}
