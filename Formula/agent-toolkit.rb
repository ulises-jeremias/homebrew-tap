class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.37.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.37.0/agent-toolkit-macos-arm64"
      sha256 "a05341aa185c30f42316429621da72632976b0030b36beef190a05eece44359d"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.37.0/agent-toolkit-macos-x86_64"
      sha256 "6e804c62e4cd0ce7cc6d83ce2be32bdc46b9ded27b9a9276b247ab37112edfba"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.37.0/agent-toolkit-linux-x86_64"
      sha256 "25e49d31cd1ffb187eda3ec872a0998851862c3254018c25aca194ea8891a24b"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.37.0/agent-toolkit-linux-arm64"
      sha256 "8860ff31f92c2749fca1d281de6fd0e5307647545c60f82415ea99019275543d"
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
