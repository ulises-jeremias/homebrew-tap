class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.30.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.30.0/agent-toolkit-macos-arm64"
      sha256 "5e7d31287a446424017666d1b001f948d66d6374495485d76521e57125aa061a"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.30.0/agent-toolkit-macos-x86_64"
      sha256 "7e00ed5c6540d833fc9a87b6be3cfa7fd09eba77c71543c93d4bc1437341f99b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.30.0/agent-toolkit-linux-x86_64"
      sha256 "9876852f2e2fd507ec6b1d5e32a7d22dcabb1528056a5fbd7814f38e3d69345f"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.30.0/agent-toolkit-linux-arm64"
      sha256 "bb98fb8ac0d5b2b02c2c741d6b47040d8299c94be9e789499214509afd58818c"
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
