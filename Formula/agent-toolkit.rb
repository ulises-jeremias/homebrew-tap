class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.13.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.13.0/agent-toolkit-macos-arm64"
      sha256 "11f61913a8a4e4948f18927e37b06864bacdbb7ecd865feb2bc0280486af5dea"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.13.0/agent-toolkit-macos-x86_64"
      sha256 "312a7b09f87b69a8816bc36606f86ef04b78c83cff3082e15c431aedd7432436"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.13.0/agent-toolkit-linux-x86_64"
      sha256 "93cd30c970251322ffe10b5b39f06fc1ae657e82d2bae1df6e79785560ee85b6"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.13.0/agent-toolkit-linux-arm64"
      sha256 "8eda0c14fbd32bf7c2d37e955c36fb3b7d7c4ced097f1af5178c1d7d5016295b"
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
