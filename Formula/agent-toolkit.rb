class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.26.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.26.0/agent-toolkit-macos-arm64"
      sha256 "c04d395281374b014a1d66ae11af710da6007197275a901913d9338dd1d07ac3"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.26.0/agent-toolkit-macos-x86_64"
      sha256 "0d784365bbc4e2e346200c49f84b1d5949e2bc0b299290047aff56d1c5bf214b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.26.0/agent-toolkit-linux-x86_64"
      sha256 "01d55aa385805f9c62de8869bfdedb395d442a15d09efea299ec8e35df4b0939"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.26.0/agent-toolkit-linux-arm64"
      sha256 "1d34b00304f8b44f664827868dc6cd5a961100fb304cd370b42814ea52e63882"
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
