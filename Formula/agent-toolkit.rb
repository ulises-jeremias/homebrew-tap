class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.15.1"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.15.1/agent-toolkit-macos-arm64"
      sha256 "52a09ace0d61c500e3e1fdc02e9f8c53c9ef18b51fc0e57ec203f63392d82a1c"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.15.1/agent-toolkit-macos-x86_64"
      sha256 "c7add9d388850a550d5e2d27901ed292a346a0e3b33b3dd1a629b55edaba919d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.15.1/agent-toolkit-linux-x86_64"
      sha256 "6e8965d288e29c5a7c4a9776d9430f48cac13a60fa4c1f9b1095fd2ba96ecc11"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.15.1/agent-toolkit-linux-arm64"
      sha256 "34e27baba16a90eccfd412f9a7316054eebbd78e79d05059266fb3df0ca827d2"
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
