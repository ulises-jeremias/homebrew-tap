class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.44.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.44.0/agent-toolkit-macos-arm64"
      sha256 "67ad0a3dd47526f29c0fb98973789960cbaa5e8e7702af701b5a7c4ff2ce66d5"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.44.0/agent-toolkit-macos-x86_64"
      sha256 "3bd1a2ac82c161dbdbcd757cd938637bc2caa7d2c0cc420ef4735f0bcdf1a854"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.44.0/agent-toolkit-linux-x86_64"
      sha256 "035f60ac3453e68b8ebac045026d2893eec709c7389f97093081ccecbf560bca"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.44.0/agent-toolkit-linux-arm64"
      sha256 "a3f1562384e6cd1fa30ffdddcd568c1a47e2c2971d6b06f38bd8f4cbd0669e5a"
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
