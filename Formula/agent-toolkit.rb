class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.35.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.35.0/agent-toolkit-macos-arm64"
      sha256 "425ff5d910f1a561e019a119a40a79ba61a7e79af287299a4c4567b17db08472"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.35.0/agent-toolkit-macos-x86_64"
      sha256 "4a0a3a050c6d7bf4edb0bad40460bea48592d9b5d285dff2283cdc8ea78f4cbe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.35.0/agent-toolkit-linux-x86_64"
      sha256 "604f3132c22407461586d91e40e3a15194b7c90bad275cef8c0a21f21d67e6f7"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.35.0/agent-toolkit-linux-arm64"
      sha256 "aaae5e206caba5e0296f809c2679896b7df87267c0e03555d02e4a22ebdb6e6b"
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
