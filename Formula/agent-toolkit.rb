class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.12.2"
  license "MIT"

  # Canonical artifacts: GitHub Release floating names (agent-toolkit ADR-018).
  # Not a Python wheel. Not a Homebrew bottle of a source build.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.2/agent-toolkit-macos-arm64"
      sha256 "0440cee628867149560cb98ae37e8a667524c2c3c5a121e66060c873a1e8ddd8"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.2/agent-toolkit-macos-x86_64"
      sha256 "b41d9221552dbd67b673d302bab61d441ed00ff0a07475570f7ae633ea993b2c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.2/agent-toolkit-linux-x86_64"
      sha256 "de12e7d0a402e139b63d0abc5e7ea465be584cb0bb6cb0f7447f83eafeed917b"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.12.2/agent-toolkit-linux-arm64"
      sha256 "837c2964b0ad432dcaf6758347cdc825cfa50fb88bbe556b98b7e5e10aeb7416"
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
