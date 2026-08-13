class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.11.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.11.0/agent-toolkit-macos-arm64"
      sha256 "81d873bd79e7fcb65def2de22d4ee3247557c03d715b217050951991d0c27d2d"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.11.0/agent-toolkit-macos-x86_64"
      sha256 "2d0561a6210e3e906a3781cd502d0f3d6bb48ea1e7630496bd10c36e306784dc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.11.0/agent-toolkit-linux-x86_64"
      sha256 "a08930158530349013029f2f5fd35c7f0a96dfdec7a19a8c14af93f554c53dd3"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.11.0/agent-toolkit-linux-arm64"
      sha256 "d8ad28372c4a549cd0ef441bc4ddcb7b3d43336186b314f6c3cb20866a18ed0e"
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
