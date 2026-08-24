class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.22.3"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.3/agent-toolkit-macos-arm64"
      sha256 "ad68956a267667e7843c1392b149f2474e91060e2613389fa77e158965e7acfb"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.3/agent-toolkit-macos-x86_64"
      sha256 "89e013e5b70ddb33d0a332893c3fd44c189a78326735be745cd2c85c2752d480"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.3/agent-toolkit-linux-x86_64"
      sha256 "833048eef3ba9d27cd33340993cd97e5f69336bb151d4b6a60163dc64e15a060"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.3/agent-toolkit-linux-arm64"
      sha256 "3ffc08402a2e5597ff69bcb07cb4b85336bd0eb62b7e687c19d4458fb5dda54c"
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
