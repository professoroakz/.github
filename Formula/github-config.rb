class GithubConfig < Formula
  desc "GitHub community health files and configuration tools"
  homepage "https://github.com/professoroakz/.github"
  url "https://github.com/professoroakz/.github/archive/refs/heads/main.tar.gz"
  version "1.3.37"
  sha256 ""  # Will be calculated on release
  license "MIT"

  depends_on "node" => :optional
  depends_on "python@3" => :optional

  def install
    bin.install "bin/github-config"
    
    (share/"github-config").install "scripts"
    (share/"github-config").install "docs"
    (share/"github-config").install ".github"
    (share/"github-config").install "profile"
    
    %w[README.md CODE_OF_CONDUCT.md CONTRIBUTING.md SECURITY.md SUPPORT.md LICENSE CHANGELOG.md].each do |file|
      (share/"github-config").install file if File.exist?(file)
    end
  end

  test do
    system "#{bin}/github-config", "version"
    system "#{bin}/github-config", "help"
  end
end
