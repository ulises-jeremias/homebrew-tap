class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.42.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.42.0/agent-toolkit-macos-arm64"
      sha256 "345aa9ec5e0cd334ae712780682f9194c9371e30f0e1400426b72fed570c70ba"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.42.0/agent-toolkit-macos-x86_64"
      sha256 "d4e98f788ee1f4d598dc6ffc4792f7a22b689176bc628854fe84aa9c74c64e11"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.42.0/agent-toolkit-linux-x86_64"
      sha256 "6b2867ff3d5c260ff079e680134a79a902436c3270f2c018662648450cf662cc"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.42.0/agent-toolkit-linux-arm64"
      sha256 "fa05b1693237becd85059bd8ee887250a70e80586863e04a872ab2a01566aa90"
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
