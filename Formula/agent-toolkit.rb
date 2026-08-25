class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.23.1"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.23.1/agent-toolkit-macos-arm64"
      sha256 "324689f6d0e88d16e7bd58659e750345303c6373ec43cf8c6cd12cf30ffb8fe3"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.23.1/agent-toolkit-macos-x86_64"
      sha256 "726b5dd93794c0e84d7f7c3db2485340a9080ee7071d7d12d9ffe140f4c6a74c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.23.1/agent-toolkit-linux-x86_64"
      sha256 "e9f6a1111713b0bb299c47c9dab9a7d60cff1b5385c3502f73fb8a8eb2b4adee"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.23.1/agent-toolkit-linux-arm64"
      sha256 "54c23db7a88004f4a9d95c5a6b15ffe999e0c403bca270f20ea4419c7c171eaa"
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
