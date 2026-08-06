class AgentToolkit < Formula
  include Language::Python::Virtualenv

  desc "Composable AI agent toolkit — loops, skills, profiles for Claude Code, Cursor, OpenCode, Windsurf, and more"
  homepage "https://github.com/ulises-jeremias/agent-toolkit"
  url "https://github.com/ulises-jeremias/agent-toolkit/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "420f67baa5a0a0d67b517cc8ac720218efb21ee8609d830427a03a86cbc6309b"
  license "MIT"
  head "https://github.com/ulises-jeremias/agent-toolkit.git", branch: "main"

  depends_on "python@3.11"

  def install
    # Source tarballs do not contain pre-built package data — they must be prepared.
    # See https://github.com/ulises-jeremias/agent-toolkit/issues/257
    odie "scripts/prepare-package-data.sh not found — source tarball missing bundled data preparation script" unless File.exist?("scripts/prepare-package-data.sh")
    system "bash", "scripts/prepare-package-data.sh"
    # Verify prepared data exists before building the wheel (built from packages/agent-toolkit-cli)
    odie "bundled data not found after prepare-package-data.sh — expected packages/agent-toolkit-cli/src/agent_toolkit/data/skills" unless File.exist?("packages/agent-toolkit-cli/src/agent_toolkit/data/skills")
    odie "bundled data not found after prepare-package-data.sh — expected packages/agent-toolkit-cli/src/agent_toolkit/data/loops" unless File.exist?("packages/agent-toolkit-cli/src/agent_toolkit/data/loops")

    venv = virtualenv_create(libexec, "python3.11")
    venv.pip_install buildpath

    # Link the agent-toolkit binary
    bin.install_symlink "#{libexec}/bin/agent-toolkit"
  end

  test do
    output = shell_output("#{bin}/agent-toolkit version")
    assert_match "agent-toolkit", output
    # Verify bundled data is detected via doctor (loops/skills bundled in wheel)
    doctor_output = shell_output("#{bin}/agent-toolkit doctor")
    assert_match "loop templates", doctor_output
  end
end
