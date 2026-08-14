class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.14.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.14.0/agent-toolkit-macos-arm64"
      sha256 "8ce5f23abb147083b47d516d95eb4aba38af3a930bc7aae2fe8fa63420d4bfd1"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.14.0/agent-toolkit-macos-x86_64"
      sha256 "bc4ac775f4faf644018fd7416a93d1400c4b39a7ad1096010ba3abfd78fc72f5"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.14.0/agent-toolkit-linux-x86_64"
      sha256 "459608e240239fb46564ebcb16b13469c87082b5829c5eaeae496061e6fea159"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.14.0/agent-toolkit-linux-arm64"
      sha256 "21ff9cb991871925a52d0b992f754a973c6850936ab172e3fdc1766e4c40a8ac"
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
