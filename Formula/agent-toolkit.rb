class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.32.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.32.0/agent-toolkit-macos-arm64"
      sha256 "5f04a546f2ff8de346d955f95be0e6146faf26655a509f33a1054cfcdb5aa83f"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.32.0/agent-toolkit-macos-x86_64"
      sha256 "cb494c30041621dec3791deea865dfddd2b0eabe4ba78d71f66b24b77849281d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.32.0/agent-toolkit-linux-x86_64"
      sha256 "baff593e04871530817e751ee05ca024423e4ffc37a11cd91618a852721b4f9a"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.32.0/agent-toolkit-linux-arm64"
      sha256 "eb937d0a5b6b9f321b11e0d439deab897b8b9612b0ca573ccf0d00c10ac5835b"
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
