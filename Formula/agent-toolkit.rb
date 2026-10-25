class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.48.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.48.0/agent-toolkit-macos-arm64"
      sha256 "2a5b850eb7201a230fa1665995fd1a3af8aed749622e110d2389fbcbfa88cb44"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.48.0/agent-toolkit-macos-x86_64"
      sha256 "4789b990cb63e4df0e1154671b9416b351027513f60916b32791105cd857e15a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.48.0/agent-toolkit-linux-x86_64"
      sha256 "401b58536221f20f38a623ca9916419798b568c7ec1fd80e98f1fb09aa8fa2e6"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.48.0/agent-toolkit-linux-arm64"
      sha256 "ff5585082803d460eddb251904e6147aff21a07360721715291cf510dd43ad7d"
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
