class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.38.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.38.0/agent-toolkit-macos-arm64"
      sha256 "d0b304a0cea348f1b03250663daca62e12feba1f0f8e77b8f35fb484e8995173"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.38.0/agent-toolkit-macos-x86_64"
      sha256 "b94b13a69ba286d42c1e656c8757280a25571ede6738cddafe558beaf8f61c0d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.38.0/agent-toolkit-linux-x86_64"
      sha256 "055055f707d4c11c380644429ede1c075eecdc58e296e67ea962a4bfb8cce7a8"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.38.0/agent-toolkit-linux-arm64"
      sha256 "72f0bff79b0a3c1298c28edb62c37e2882a68a5f8f58b09e5752f3e48fb64d52"
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
