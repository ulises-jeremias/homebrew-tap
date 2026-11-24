class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.50.0"
  license "MIT"

  # GitHub Release binaries are used until a release publishes versioned
  # standalone archives. The updater switches these URLs to archives, which
  # contain the executable, its pinned offline bundle, and the license.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.50.0/agent-toolkit-1.50.0-macos-arm64.tar.gz"
      sha256 "9698ed2429a7fe3abbe34a7e4626bb854240bb4ed8bbb551148191cdfc39824e"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.50.0/agent-toolkit-1.50.0-macos-x86_64.tar.gz"
      sha256 "dd53cd7a3b6f6ebba14b5e8cf27de160c24bee6d88af4abbaaacdb9cb8399cc3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.50.0/agent-toolkit-1.50.0-linux-x86_64.tar.gz"
      sha256 "0390bcc90dd195d69c46ce5cba53dc43285d5a071334e8d9ed285d7b376c2fe4"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.50.0/agent-toolkit-1.50.0-linux-arm64.tar.gz"
      sha256 "8b84e0ca93c0b169bed0ada0e935b32998115a634cbeccb6449daf185e382f33"
    end
  end

  def install
    binary = Dir["agent-toolkit*"].find do |path|
      File.file?(path) && !path.end_with?(".tar.gz", ".zip", ".bundle.gz")
    end
    raise "GitHub Release did not provide an Agent Toolkit executable" unless binary

    bin.install binary => "agent-toolkit"
    if url.end_with?(".tar.gz") && !File.file?("embedded_data.bundle.gz")
      raise "standalone release archive is missing its offline resource bundle"
    end
    if File.file?("embedded_data.bundle.gz")
      bin.install "embedded_data.bundle.gz"
      lib.install "LICENSE" if File.file?("LICENSE")
    end
  end

  test do
    output = shell_output("#{bin}/agent-toolkit version")
    assert_match "agent-toolkit", output
  end

  def caveats
    <<~EOS
      This formula installs the native V binary and matching offline resources from GitHub Releases
      (https://github.com/ulises-jeremias/agent-toolkit/releases), not the
      Python wheel. `brew upgrade` owns the binary; `agent-toolkit update`
      only refreshes skills/profiles.
    EOS
  end
end
