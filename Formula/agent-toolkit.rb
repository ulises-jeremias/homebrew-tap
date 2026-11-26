class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.51.1"
  license "MIT"

  # GitHub Release binaries are used until a release publishes versioned
  # standalone archives. The updater switches these URLs to archives, which
  # contain the executable, its pinned offline bundle, and the license.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.51.1/agent-toolkit-1.51.1-macos-arm64.tar.gz"
      sha256 "28cc8f4d767eb8e0aea6ad7560027637493d43f74093bf92264a87f18943ddf7"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.51.1/agent-toolkit-1.51.1-macos-x86_64.tar.gz"
      sha256 "151f6277db9dcb34ed89940061abfd1b9d5e7172a06cfefbc19a4f797ca2c768"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.51.1/agent-toolkit-1.51.1-linux-x86_64.tar.gz"
      sha256 "e278100183cbe89fee4a906c07d7a7dcefa407e048ceb872986694d806fb7ef9"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.51.1/agent-toolkit-1.51.1-linux-arm64.tar.gz"
      sha256 "38ff0ff4ccc3a428606858f0db5517310a48a083337347e77151216378857268"
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
