class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.39.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.39.0/agent-toolkit-macos-arm64"
      sha256 "bed32e0c447aa37e8c28fb899f984eb5e3d8a98d6330185318793f3eeaf9530c"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.39.0/agent-toolkit-macos-x86_64"
      sha256 "c355c7f68773bc0b2a558498e75a3c4918357897ffb8f3e3b8e734e4a1048a37"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.39.0/agent-toolkit-linux-x86_64"
      sha256 "5dbd731ef02ccffd99fb538ec0c82161928740a9a3bbc0f10b88452dbac8a6dc"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.39.0/agent-toolkit-linux-arm64"
      sha256 "726f17e372d4730d1bf0c6d0c5637b246bc28729ecac545d01e03e8c9cb3328a"
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
