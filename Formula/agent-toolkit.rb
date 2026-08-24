class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.22.1"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.1/agent-toolkit-macos-arm64"
      sha256 "f9d0eef4ed3ce9960e0a77e578c519e4fc585f2a80b799fe448aec61080b5956"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.1/agent-toolkit-macos-x86_64"
      sha256 "8b85f482572f54873654b3c3e00a96743373673c6df8d5ea9b40d5aec62d29be"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.1/agent-toolkit-linux-x86_64"
      sha256 "4a84098fa40e76b5631d064080c27798046e76c826e0be6877ecd52da93f40d3"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.22.1/agent-toolkit-linux-arm64"
      sha256 "3ae2c4528c551d341d655549789d4c444ffc42c481037f5babfa1a421edff300"
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
