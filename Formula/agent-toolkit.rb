class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.22.2"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.2/agent-toolkit-macos-arm64"
      sha256 "5bf95981e9c10f771dc6d4e8747c530f68d9b6f9643cfd2eedc63cb002247a86"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.2/agent-toolkit-macos-x86_64"
      sha256 "28990f319a9a3b7aaed392f5f0b3d678f6e9575c8ace395810fc82e4d0a806a5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.2/agent-toolkit-linux-x86_64"
      sha256 "a5c7a298d21ea9c9aac078bc9d57dfeec87c77698c5e0382c0122c82646245d0"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.2/agent-toolkit-linux-arm64"
      sha256 "95e2316d805c881d693beedf4b7a483f5434edb9f4800572e6a233553a520971"
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
