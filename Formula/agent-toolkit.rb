class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.16.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.16.0/agent-toolkit-macos-arm64"
      sha256 "617381d20f731a904865acea69deb1323519113b12de4d7bb3034ded9249f730"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.16.0/agent-toolkit-macos-x86_64"
      sha256 "bd2df3037732e440ebaae6227a3ee31d6c8f611e578397704226d1335ca8298e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.16.0/agent-toolkit-linux-x86_64"
      sha256 "c19a47ca4763b127682d3461442e1fdcbe2a1d5cf58761302f4a49787eb7426a"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.16.0/agent-toolkit-linux-arm64"
      sha256 "9470f48a476337cfc22960cf1018644cc1b978fff3385b80e4f2487a8a0c5bee"
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
