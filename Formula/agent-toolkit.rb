class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.18.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.18.0/agent-toolkit-macos-arm64"
      sha256 "ebd8c4bd443aa2eea8aaf98711dc7da50d367bc21c84f4bee71c48bfc2b46dfd"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.18.0/agent-toolkit-macos-x86_64"
      sha256 "a6b74f0192e0dd990f2566d610cbe3fecedfb33682f1c9017d3411c58bebffdf"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.18.0/agent-toolkit-linux-x86_64"
      sha256 "b640ecfd751cec90b821af0432410a514aea5ba20c762c11e3e33bb0a1956568"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.18.0/agent-toolkit-linux-arm64"
      sha256 "e4ceac3e2898949e4d94083ed2079f40c2fa2fbf1afe56c32f735b748bd643bb"
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
