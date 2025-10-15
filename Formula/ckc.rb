class Ckc < Formula
  desc "Create a kind cluster and bootstrap Helm charts"
  homepage "https://git.rhynosaur.com/akyriako/ckc"
  url "https://git.rhynosaur.com/akyriako/ckc/archive/v0.1.0.tar.gz"
  sha256 "73342414775eee76e4edf07ffee5881110ddafbe6afc59f4a8237744c7c7d52c"
  license "MIT"

  depends_on "kind"
  depends_on "helm"
  depends_on "kubernetes-cli" # kubectl
  # depends_on "bash" => :run  # uncomment if your script needs Bash 4+ on macOS

  def install
    # Install bundled config(s)
    pkgshare.install "multinode-kind-cluster.yaml"

    # Make the default config path stable inside the keg
    inreplace "create-cluster-bundle.sh",
              'KIND_CONFIG="multinode-kind-cluster.yaml"',
              "KIND_CONFIG=\"#{pkgshare}/multinode-kind-cluster.yaml\""

    # Install the main script as `ckc`
    bin.install "create-cluster-bundle.sh" => "ckc"
  end

  test do
    output = shell_output("#{bin}/ckc --help")
    assert_match "Usage:", output
  end
end
