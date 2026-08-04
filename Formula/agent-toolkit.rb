class AgentToolkit < Formula
  include Language::Python::Virtualenv

  desc "Composable AI agent toolkit — loops, skills, profiles for Claude Code, Cursor, OpenCode, Windsurf, and more"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  url "https://github.com/ulises-jeremias/agent-toolkit/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "PLACEHOLDER_SHA256"
  license "MIT"
  head "https://github.com/ulises-jeremias/agent-toolkit.git", branch: "main"

  depends_on "python@3.11"

  def install
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
