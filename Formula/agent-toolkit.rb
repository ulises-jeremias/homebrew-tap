class AgentToolkit < Formula
  include Language::Python::Virtualenv

  desc "Composable AI agent toolkit — loops, skills, profiles for Claude Code, Cursor, OpenCode, Windsurf, and more"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  url "https://github.com/ulises-jeremias/agent-toolkit/archive/refs/tags/v1.3.0.tar.gz"
  sha256 "1d23e5ca818c39c07095d79cabda4c376c612ba81339cf59bb6e4c6d2bdab409"
  license "MIT"
  head "https://github.com/ulises-jeremias/agent-toolkit.git", branch: "main"

  depends_on "python@3.11"

  def install
    # Ensure bundled skills/loops/agent data are prepared before building the wheel —
    # the source tarball requires scripts/prepare-package-data.sh (PyPI wheels already contain it).
    # See https://github.com/ulises-jeremias/agent-toolkit/issues/257
    system "bash", "scripts/prepare-package-data.sh" if File.exist?("scripts/prepare-package-data.sh")
    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install buildpath

    # Link the agent-toolkit binary
    bin.install_symlink "#{libexec}/bin/agent-toolkit"
  end

  test do
    output = shell_output("#{bin}/agent-toolkit version")
    assert_match "agent-toolkit", output
  end
end
