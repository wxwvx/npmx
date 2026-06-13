class Npmx < Formula
  desc "Interactive NPM script runner for Zsh"
  homepage "https://github.com/wxwvx/npmx"
  url "https://github.com/wxwvx/npmx/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "54ab3dba1ccb6e29eb3af9c18fd6a400e1c7f9888388b411f16c9170b6adbe52"
  license "MIT"

  depends_on "fzf"
  depends_on "jq"

  def install
    bin.install "npmx.sh" => "npmx"
  end

  test do
    (testpath/"package.json").write('{"scripts":{"test":"echo ok"}}')
    assert_match "test", shell_output("#{bin}/npmx list")
  end
end
