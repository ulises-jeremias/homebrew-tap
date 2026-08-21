class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.17.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.17.0/agent-toolkit-macos-arm64"
      sha256 "daef0aeb10cc24d42d7458e4fb636b31186dba4d7161ed07e502ef20c421c183"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.17.0/agent-toolkit-macos-x86_64"
      sha256 "6d56a5939fb905a97148c31fa7e9fc97dbea23abf69e6381f019d8e0b5dfcc9a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.17.0/agent-toolkit-linux-x86_64"
      sha256 "995163cf372df93e2ac637e72645fc8d4f749bbbda177175b17b63899b07ac3f"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.17.0/agent-toolkit-linux-arm64"
      sha256 "bc74ca16d496ff6ea5735b09029eed497e4fdf7383839be73a1674dcad70c38c"
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
