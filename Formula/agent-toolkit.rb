class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.47.2"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.2/agent-toolkit-macos-arm64"
      sha256 "b254c9ec4c5c5f6e6f5ff9f523fb012c2008b63e62fd2ec1de2ce69a097fc774"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.2/agent-toolkit-macos-x86_64"
      sha256 "b90f19f18c6f5152cbc32cb65bfc49746c4f50973080ead7c556bc965967d526"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.2/agent-toolkit-linux-x86_64"
      sha256 "dba7bab0c3e9f9232a7d08de27c21178f909e75bb3d4bbf7cd5f87e963021989"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.2/agent-toolkit-linux-arm64"
      sha256 "21ea75226d3f015daa13197ea04314349229e2c548c8a990cc1d1c2a906d4bb7"
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
