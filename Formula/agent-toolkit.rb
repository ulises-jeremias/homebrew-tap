class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.21.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.21.0/agent-toolkit-macos-arm64"
      sha256 "498c6815a66ffab5d3625b4dc23b24a158745a5dc01e869e8b1ec8fc253908dd"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.21.0/agent-toolkit-macos-x86_64"
      sha256 "1a4e440b8bf2718b7b2851f0a2be6af7b8b9deafdc69ac79d7a437d9477c6298"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.21.0/agent-toolkit-linux-x86_64"
      sha256 "a2e88d4ab5b1733e35d8b91bf54b24bbcf0c2c1ac401f561123ef6a9c9b2ca44"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.21.0/agent-toolkit-linux-arm64"
      sha256 "c3d539cc23b0d4b2d4ce6b2eb5a7212a4e7402d2de172877f6e91c9f3c3d17cd"
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
