class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.47.6"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.6/agent-toolkit-macos-arm64"
      sha256 "608149cdd1d0b3877fc5ef750d8ec937185b6f243c64b2223af8f662a9b70730"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.6/agent-toolkit-macos-x86_64"
      sha256 "4495824540a9e25e80f9ba151fef94e5c55dabafc24c4145d680b58f6a2f2d52"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.6/agent-toolkit-linux-x86_64"
      sha256 "f006a9d682191725176a4b1709364fe32a3f3d9be26976ad72f52584d4de222c"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.47.6/agent-toolkit-linux-arm64"
      sha256 "64d0e3e21b9d06a5bef266cb52187587c35b04d717676698ac047aacee5e365f"
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
