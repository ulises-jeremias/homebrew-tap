class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.33.1"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.33.1/agent-toolkit-macos-arm64"
      sha256 "b1e82d26d7d857af195b0d788f2744cafee15c91c448f5da6af5803c0be45a0b"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.33.1/agent-toolkit-macos-x86_64"
      sha256 "5f5a0542c4ff5c17177a1ae5fbf5ee6b98e88ad11b89a9eef5f5d52d9d846a16"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.33.1/agent-toolkit-linux-x86_64"
      sha256 "0a8bad8ea44dcdb774f696455e954f2ca8a49e49c494dc7251260642e578b665"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.33.1/agent-toolkit-linux-arm64"
      sha256 "146536311eb5dacde5591f133df6163d7c02272791d05ff8983f1d8cf29d6e8c"
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
