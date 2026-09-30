class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.36.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.36.0/agent-toolkit-macos-arm64"
      sha256 "ed8c41313a32af088435f9531c7ba05f1d69759b6f919d9fc95e92c8ef6658cc"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.36.0/agent-toolkit-macos-x86_64"
      sha256 "3f76da1fccedfc49c850b5308be17cc264b39977b0699fa538fc66a9454860e1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.36.0/agent-toolkit-linux-x86_64"
      sha256 "f976bbb646774f32933200c75ed6e4cce1311910e867bbd6482c9dfffb25fdd2"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.36.0/agent-toolkit-linux-arm64"
      sha256 "a94755ec34affd4dc68787c6a39c5401e1c8e2b0596777084b8df365da570be2"
    end
  end

  def install
    bin.install Dir["agent-toolkit*"].first => "agent-toolkit"
  end

  test do
    output = shell_output("#{bin}/agent-toolkit version")
    assert_match "agent-toolkit", output
  end

  def caveats
    <<~EOS
      This formula installs the native V binary from GitHub Releases
      (https://github.com/ulises-jeremias/agent-toolkit/releases), not the
      Python wheel. `brew upgrade` owns the binary; `agent-toolkit update`
      only refreshes skills/profiles.
    EOS
  end
end
