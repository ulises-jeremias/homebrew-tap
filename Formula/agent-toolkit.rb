class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.30.3"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.30.3/agent-toolkit-macos-arm64"
      sha256 "2b04d67bfe8b901a2ebd797f377d4f7d2fc46c4761890be3b19b245e09c81cd3"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.30.3/agent-toolkit-macos-x86_64"
      sha256 "8428077e2591a2b689d3209554a5c829b65e15b7ede29c4c22fa42f283120e31"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.30.3/agent-toolkit-linux-x86_64"
      sha256 "ecf3737c0ddb051efb03f4db91c37eaf87de0b7fd2deb44a4855657c2b5b96f8"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.30.3/agent-toolkit-linux-arm64"
      sha256 "4ab5bd39cb3ec08f51810fc2f6763576fe2f63388b10a48df17278845294a033"
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
