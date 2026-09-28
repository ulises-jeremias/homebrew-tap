class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.34.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.34.0/agent-toolkit-macos-arm64"
      sha256 "5acfc73f60d7f2eda68b790e2e13ca1f5d3a18c1c81d806f276dce48e34ebb18"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.34.0/agent-toolkit-macos-x86_64"
      sha256 "80da8f332b8679c4f6876e5541a467493576577b3b215913b5c8f72603ed0933"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.34.0/agent-toolkit-linux-x86_64"
      sha256 "b660d6e7e780a9b69b6886c9406347d021f90405326a639b5f387ed411da7e19"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.34.0/agent-toolkit-linux-arm64"
      sha256 "178db6dcdbbe14932cd8070a3b39368f11a8e614d6da5ef7daedd5e24780f99f"
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
