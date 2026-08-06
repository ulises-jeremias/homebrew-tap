class AgentToolkit < Formula
  include Language::Python::Virtualenv

  desc "Composable AI agent toolkit — loops, skills, profiles for Claude Code, Cursor, OpenCode, Windsurf, and more"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  url "https://github.com/ulises-jeremias/agent-toolkit/archive/refs/tags/v1.4.1.tar.gz"
  sha256 "47c90978f74c4824e335e2330125232143997144c2958a220c5108825bb645b1"
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
