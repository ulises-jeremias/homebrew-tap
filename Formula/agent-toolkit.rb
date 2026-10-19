class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.47.4"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.4/agent-toolkit-macos-arm64"
      sha256 "61ef2adac5a0abc9eb9107d29264448da0389eb839290977adfeaeac22f87831"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.4/agent-toolkit-macos-x86_64"
      sha256 "5937590bbafeb01f28bab9df30e749615704baae72876acbdbeebf0e9c0916e7"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.4/agent-toolkit-linux-x86_64"
      sha256 "8358444d4e133db642b4de4b1796b4e42a08444437a7b0049cc406e5685bb603"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.4/agent-toolkit-linux-arm64"
      sha256 "62bd1087c7b7235c3ba00cddfc5863452a192364b3655b307d7612e6bb3a8c47"
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
