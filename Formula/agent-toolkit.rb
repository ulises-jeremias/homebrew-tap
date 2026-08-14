class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.14.1"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.14.1/agent-toolkit-macos-arm64"
      sha256 "79ed3e272f434fc2a3b444ad9b9f1d236d66b9620f464ad2d69f12bf76b482bb"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.14.1/agent-toolkit-macos-x86_64"
      sha256 "852f2eb7871f1ea2f9bac3133241ee9361939d2a5bc9b57af796ed3ff1b8e30d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.14.1/agent-toolkit-linux-x86_64"
      sha256 "3b0dd484d624a059d04d073c8df210bf82d29e597053be2b0944905ae589ccd7"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.14.1/agent-toolkit-linux-arm64"
      sha256 "ba1e788e3ad94795898b209f46809dbb85b365a02ffa83a5d7507bca15738e0c"
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
