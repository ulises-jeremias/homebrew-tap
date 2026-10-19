class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.47.3"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.3/agent-toolkit-macos-arm64"
      sha256 "7e52e5b2104d7de033cea057e74f38c38c45b5c9de6683d9157e7b2210f24fbb"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.3/agent-toolkit-macos-x86_64"
      sha256 "4cf478a92da6a6b9b475c30af00bc25808f675e4096b9dee56fa6daf874fdb56"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.3/agent-toolkit-linux-x86_64"
      sha256 "c20e8022f648c8dc93882bb8d14a2b35eb2c15945e69e4e6a821424265461cde"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.3/agent-toolkit-linux-arm64"
      sha256 "61e7a5d2b815e0885d038a2f4fb5e5c411ec158216952ff45736830c07e1a8c1"
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
