class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.12.0"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.0/agent-toolkit-macos-arm64"
      sha256 "b0cae2302ab6d27fb85f315012276722a9760de1d0fd6d2b5881e32137a83dac"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.0/agent-toolkit-macos-x86_64"
      sha256 "eb2c111f6930eb5b121143359986313b6460f5c457f3579f05cfd064bafa65f4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.0/agent-toolkit-linux-x86_64"
      sha256 "1f8f0b44a81f7633f4281752fc11111e5e04954809195950c1e2e91fae1fee2a"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.0/agent-toolkit-linux-arm64"
      sha256 "196c2f68d5b2cf24f6d89bbda418c865749eae719b0c8733bfc4a75fb467261c"
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
