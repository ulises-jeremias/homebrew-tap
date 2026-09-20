class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.32.1"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.32.1/agent-toolkit-macos-arm64"
      sha256 "5dcf76aa933c4f84948aa62bb5aee2d0e4a66a0d3ff009d1f64565a4e2bc593f"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.32.1/agent-toolkit-macos-x86_64"
      sha256 "2353a1d094fc9fef52fa3a9b8f4941857598180ffd49ec28afcfbf2525a9672d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.32.1/agent-toolkit-linux-x86_64"
      sha256 "1efbfd445cecbbf8f5facdbeeada6c5aec9f61ee711c29ede4f458c40fa84b86"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.32.1/agent-toolkit-linux-arm64"
      sha256 "d6ba0bf918223513925fc3941b0de6102419b479db15f6b7c7c873e26c1023b1"
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
