class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.23.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.23.0/agent-toolkit-macos-arm64"
      sha256 "fee73b85581df7a0498fb6592a5e555cedb2487e66729052729325830c0f5d04"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.23.0/agent-toolkit-macos-x86_64"
      sha256 "ef090981b102333fa67490268f9633aa8f67ad313527b5dad2306d3f3a6dab04"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.23.0/agent-toolkit-linux-x86_64"
      sha256 "f49820acafa4187285206637e2f6eb473a7c3c2cfdba9c15c28be283c2348991"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.23.0/agent-toolkit-linux-arm64"
      sha256 "c2d5c08d7e9cf8b6253467ae3d8eee5eeab7bf851eb21b032df54a10a942dfb1"
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
