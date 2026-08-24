class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.20.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.20.0/agent-toolkit-macos-arm64"
      sha256 "fd90de1d0336c31749a40f3412e0b100ef1d94ebf1e2fbb97b509d7f7d6fcc1c"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.20.0/agent-toolkit-macos-x86_64"
      sha256 "de330b2794b2fab7c62c973a6aba67640f2bca31d5e271db20ca7833116a0cb3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.20.0/agent-toolkit-linux-x86_64"
      sha256 "15513ef09cf3b111c507fa3a0d93371a23864b52c79c74cf8d903451d92bbeeb"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.20.0/agent-toolkit-linux-arm64"
      sha256 "a7970ad4b71d5484290e2862bf36bb1ada571dd4c4000aadeef6cab3dfde727e"
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
