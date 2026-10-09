class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.43.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.43.0/agent-toolkit-macos-arm64"
      sha256 "39dda3c54cf17df9d86f10dd0f98716acc241e712c649ab3a87adeee34e46123"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.43.0/agent-toolkit-macos-x86_64"
      sha256 "3e0d4c6b9e7f369702812441ab15f72b9836bab2e5192fcb0304295550b5d31b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.43.0/agent-toolkit-linux-x86_64"
      sha256 "0e6ee21e358bfd6455fbbe2c1eaf204692e3292f4831afe94c4fb48b744c5ccd"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.43.0/agent-toolkit-linux-arm64"
      sha256 "4a35239f0826e4b14fedc0845e9647984406c3b32c979feaaf77be44b7d89e8d"
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
