class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.12.1"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.1/agent-toolkit-macos-arm64"
      sha256 "4716f4e0064293f3ebb7bf3738f4bdff2904ccaabdbe452184070d903111ac98"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.1/agent-toolkit-macos-x86_64"
      sha256 "7b936365629212c192d1e0794e1c3ff85ae456d83f3219a188a8a65c8d7c3acc"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.1/agent-toolkit-linux-x86_64"
      sha256 "97c01cac02bac3a1b1742bc6b7a8c767d145149b4ba98de8b0316599dfb458a2"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.1/agent-toolkit-linux-arm64"
      sha256 "0df792e832da5777965f806dd6432dfba2bee4f8acca146200f017f65e322b0c"
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
