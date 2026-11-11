class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.49.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.49.0/agent-toolkit-macos-arm64"
      sha256 "136e158b339f7182a905217179492dc59db1ef6a4bc6e011abf578a07221ef88"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.49.0/agent-toolkit-macos-x86_64"
      sha256 "e57ce9799e8ffa2bdcf94987e30731423833a5418883b34e989e692a7e7355c1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.49.0/agent-toolkit-linux-x86_64"
      sha256 "2f14ccb846110a7ecf854931cc88b0bf9c564a54f071fbda595a8ee6a5f77a92"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.49.0/agent-toolkit-linux-arm64"
      sha256 "a58c9a8eda36b90dcc81677e3c3cf00f00ace1edfbe22d0d21b438168bff0795"
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
