class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.47.1"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.1/agent-toolkit-macos-arm64"
      sha256 "c20cf19dc68da1ac7664ee3166c86178df978a23f158252c85d15efbc897230c"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.1/agent-toolkit-macos-x86_64"
      sha256 "a90fe0bfa85fd9fb71f927adf65f59314c3d714cc7faf318fbdd6f050b18d630"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.1/agent-toolkit-linux-x86_64"
      sha256 "b44005c1072827247c3e12e5afc1d325a44e7492aab3685134ee18b813d4aab4"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.1/agent-toolkit-linux-arm64"
      sha256 "f6199d6d4c78cc663c58131cdf1345a818257872ff12ae1076bfadb04284f8e6"
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
