class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.27.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.27.0/agent-toolkit-macos-arm64"
      sha256 "13ccfcb5c7ae901e816a4d6885d4322343e5e3b7ffbb36eca9a87688081f6b7f"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.27.0/agent-toolkit-macos-x86_64"
      sha256 "ede6a5ba56f65498c591e2cf1eb6fcb4b577708031101418b9545f7ea7ef0884"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.27.0/agent-toolkit-linux-x86_64"
      sha256 "f0087625a53c6ee9b12ead042a62c3ead67589e398e05ba618ac50b925b854c4"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.27.0/agent-toolkit-linux-arm64"
      sha256 "0a80ec13ce99edfe05e29180cfbfc1af4691e03e42437e68ddfde1f9dd604f97"
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
