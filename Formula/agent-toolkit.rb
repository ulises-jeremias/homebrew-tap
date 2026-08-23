class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.19.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.19.0/agent-toolkit-macos-arm64"
      sha256 "2256ee8532f9d6a8f3b3337d6b48b90e60462487e44d90aee718b002abf64193"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.19.0/agent-toolkit-macos-x86_64"
      sha256 "5668b6957958c9ab60ac723226f380e98d8b7a8bbb862c259122ef802022ecb1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.19.0/agent-toolkit-linux-x86_64"
      sha256 "88ac64c1d83d724023019942cf3d629a503afac575c3e9917e43abf855c70f39"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.19.0/agent-toolkit-linux-arm64"
      sha256 "b6b00f3dce2cb55b48ffa4407534af76fa579bedf223fa884fc3806971fcd470"
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
