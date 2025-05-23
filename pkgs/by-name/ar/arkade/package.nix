{
  lib,
  buildGoModule,
  fetchFromGitHub,
  installShellFiles,
}:

buildGoModule rec {
  pname = "arkade";
  version = "0.11.38";

  src = fetchFromGitHub {
    owner = "alexellis";
    repo = "arkade";
    rev = version;
    hash = "sha256-V6ms3Av0/g2S7Q2NLltz7CnnvE1m+cemmwoHKL1e0tM=";
  };

  env.CGO_ENABLED = 0;

  nativeBuildInputs = [ installShellFiles ];

  vendorHash = null;

  # Exclude pkg/get: tests downloading of binaries which fail when sandbox=true
  subPackages = [
    "."
    "cmd"
    "pkg/apps"
    "pkg/archive"
    "pkg/config"
    "pkg/env"
    "pkg/helm"
    "pkg/k8s"
    "pkg/types"
  ];

  ldflags = [
    "-s"
    "-w"
    "-X github.com/alexellis/arkade/pkg.GitCommit=ref/tags/${version}"
    "-X github.com/alexellis/arkade/pkg.Version=${version}"
  ];

  postInstall = ''
    installShellCompletion --cmd arkade \
      --bash <($out/bin/arkade completion bash) \
      --zsh <($out/bin/arkade completion zsh) \
      --fish <($out/bin/arkade completion fish)
  '';

  meta = with lib; {
    homepage = "https://github.com/alexellis/arkade";
    description = "Open Source Kubernetes Marketplace";
    mainProgram = "arkade";
    license = licenses.mit;
    maintainers = with maintainers; [
      welteki
      techknowlogick
      qjoly
    ];
  };
}
