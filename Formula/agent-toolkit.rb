class AgentToolkit < Formula
  include Language::Python::Virtualenv

  desc "Composable AI agent toolkit — loops, skills, profiles for Claude Code, Cursor, OpenCode, Windsurf, and more"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  url "https://github.com/ulises-jeremias/agent-toolkit/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "fe01e692ccafc55edc354ec39379247d5c7b4a00d88efb171e64c0a5ac5ae618"
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
