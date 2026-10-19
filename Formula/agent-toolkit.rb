class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.47.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.0/agent-toolkit-macos-arm64"
      sha256 "ecb091703d17ffc58998bb3c77a32eeda579aea521742a3fb775888d61701c10"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.0/agent-toolkit-macos-x86_64"
      sha256 "422450dfc5209707f6f9ce524dd9b54165e1238422418b851d41057bdc206fa3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.0/agent-toolkit-linux-x86_64"
      sha256 "46f7d8b60bae03ee39c6d2a1d283cabd6f019d6077b82a9ad7cae890dc93b183"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.0/agent-toolkit-linux-arm64"
      sha256 "442870d2a6008d2cca3fed88481ca0790fd1e37a54981aeed7339c7cce34a54b"
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
