class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.41.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.41.0/agent-toolkit-macos-arm64"
      sha256 "5edc303795738c82b6fda07ea3bfbb598cf8d032b4782ec52d1cfb92ab2c10d3"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.41.0/agent-toolkit-macos-x86_64"
      sha256 "c373fee8c545f78d2b6b8be2c1780b79a2fd1c8c03f8e6cdfdd0445fae90183c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.41.0/agent-toolkit-linux-x86_64"
      sha256 "e7d86daa2c983a4b4c5ae8891bc6d7272659b8d898a81dcdad6561ca938019e8"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.41.0/agent-toolkit-linux-arm64"
      sha256 "256079d7848cc494635521cf1f2708216efe17dcfd372861e221a0d2d178541b"
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
