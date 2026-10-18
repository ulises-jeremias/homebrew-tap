class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.46.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.46.0/agent-toolkit-macos-arm64"
      sha256 "4b1d517bad0178317d2a5bf849b4375aee4c8b5c5502a3e4b143d074a7b8a3a8"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.46.0/agent-toolkit-macos-x86_64"
      sha256 "dcbac3168831ce2a5cb7c01536ce55ef72b209789f8d49b197099cf7a3a1758f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.46.0/agent-toolkit-linux-x86_64"
      sha256 "b01f3e5430dc864f7baedfb91e3d1c2df33a80ae1118045f43c5c7e34440031f"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.46.0/agent-toolkit-linux-arm64"
      sha256 "c09fd5ea848b6f6a8aa22a37eca729bfeb2a7e9a03f00baa2ae78c73982c79d1"
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
