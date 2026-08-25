class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.24.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.24.0/agent-toolkit-macos-arm64"
      sha256 "2588ddb5c84a6e4b17f5f08fab07b588f5e0ae95848db4a2ee7ea121ad4cca50"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.24.0/agent-toolkit-macos-x86_64"
      sha256 "0024d16c43aa09cf8900b9e1edb85e0561f1670ba1e80ca03113f37289d24b69"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.24.0/agent-toolkit-linux-x86_64"
      sha256 "bfc96944c23b557a9d80a9b89324c58a5708002e29bec60a66e8e8ef60410c91"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.24.0/agent-toolkit-linux-arm64"
      sha256 "136383f439c570a429a4428e606d7d5d2de9ac0e79f18fb7cd39237fec7edb15"
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
