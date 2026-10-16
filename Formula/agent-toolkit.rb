class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.45.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.45.0/agent-toolkit-macos-arm64"
      sha256 "c4134662e9076e5def6dd01d3e76f39f063d84e763adb72e6482194d9f83fc96"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.45.0/agent-toolkit-macos-x86_64"
      sha256 "16d85c050ccea0e7d052d2e415654f81f40b21cd6f07617657e339a6c7386a78"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.45.0/agent-toolkit-linux-x86_64"
      sha256 "0fb58da3cb3ed7071dc168d943f6b81a0ff747573bdad0c6ab507252e5eafa35"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.45.0/agent-toolkit-linux-arm64"
      sha256 "9879bc3db61dd6bc44b4ed1ae7825cc094a8014dcb383d0126b1a425df4f72a2"
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
