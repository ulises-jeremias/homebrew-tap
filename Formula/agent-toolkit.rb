class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.33.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.33.0/agent-toolkit-macos-arm64"
      sha256 "dafd9169aafe8a9a8af093647b186ffc8c3b9ae1a0968cbbc95c18c6fb6fbc28"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.33.0/agent-toolkit-macos-x86_64"
      sha256 "9397707998fc81d7ccecf9ef1660243f89761cdd758e649da661c558fbc26f82"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.33.0/agent-toolkit-linux-x86_64"
      sha256 "ab482ba83acc287cbad9bc2d193c15aa6300175ac56081f3841c7d2487b568d3"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.33.0/agent-toolkit-linux-arm64"
      sha256 "d84630e180bd01ded4b4d861a47531b1bd4505c4b15b94ed2a45f429ccf47e32"
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
