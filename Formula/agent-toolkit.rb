class AgentToolkit < Formula
  desc "Composable AI agent toolkit — native V CLI (GitHub Release binaries)"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  version "1.45.1"
  license "MIT"

  # GitHub Release binaries are used until a release publishes versioned
  # standalone archives. The updater switches these URLs to archives, which
  # contain the executable, its pinned offline bundle, and the license.

  on_macos do
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.45.1/agent-toolkit-macos-arm64"
      sha256 "ba75f0dd499c761c04753e2414b594291ae59b10c76c3babb7662de86186c429"
    end
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.45.1/agent-toolkit-macos-x86_64"
      sha256 "bf42e62c70e93ca91a60467d82fa7ab3065b50092f12a28474701bc24fbde170"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.45.1/agent-toolkit-linux-x86_64"
      sha256 "61c83b89ec47f22efb2a951f936be840a3bf981b07d8d2c85be3ff7d758c8624"
    end
    on_arm do
      url "https://github.com/ulises-jeremias/agent-toolkit/releases/download/v1.45.1/agent-toolkit-linux-arm64"
      sha256 "b2802e6725191f0cc5e00187e33c0931ad6429dd2b1bce254b022ec32c2c7f6e"
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
