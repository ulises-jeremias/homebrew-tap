class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.22.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.0/agent-toolkit-macos-arm64"
      sha256 "1b49fd1bfd8064de8c76f05f6beb6205d1ec86fab3c6b28876119a5dd908c050"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.0/agent-toolkit-macos-x86_64"
      sha256 "6c674498c36c2e0818d4d3bcd41f40d63b34d85c824c352dae824c9ca0e9f469"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.0/agent-toolkit-linux-x86_64"
      sha256 "5f2e95c68a80e02fa1f8a50b1641635ca1580190e0cbaa3bf533317b38120ef9"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.0/agent-toolkit-linux-arm64"
      sha256 "7cd68dc43800bf9f977ea303c6e8dffc19f54d4bfb73a5365a4fe001036c8034"
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
