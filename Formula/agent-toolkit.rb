class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.40.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.40.0/agent-toolkit-macos-arm64"
      sha256 "d72d6912819908f4a1cd133fc4574566f13b2c581805c2c6fc8ce9e21227874f"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.40.0/agent-toolkit-macos-x86_64"
      sha256 "92b600f7470cd4b7f0984e440e023fc90362a21327bdbd14d53ab6e293424d44"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.40.0/agent-toolkit-linux-x86_64"
      sha256 "e877cf0bf4693dd8fa14d23cde7698797d350162cd24c9c676bd7e747c85b6ae"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.40.0/agent-toolkit-linux-arm64"
      sha256 "5a6d029fe994b92f39b6fb3e3cfe3fa17b3739e78cd5084f0eb7ee0caaa4163e"
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
