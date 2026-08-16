class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.15.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.15.0/agent-toolkit-macos-arm64"
      sha256 "e405d5a93b3ae21375e636636e5605a5af0406e9e01c5cd132ec7d05cde6d5b0"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.15.0/agent-toolkit-macos-x86_64"
      sha256 "2af3ff9b7429805ae1e2c043c7439065812f0f49ffe6bd7311d8fe9f7513ef1a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.15.0/agent-toolkit-linux-x86_64"
      sha256 "fd11fec17db6fed95be7d910c1769cbe485025cea1571b124f669f8d898c3007"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.15.0/agent-toolkit-linux-arm64"
      sha256 "8f202c74153f1776a82255fff0a3332b01f16877f0118e5014734fbca048c781"
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
