class GithubConfig < Formula
  desc "GitHub configuration repository containing profile settings, workflows, and project configurations"
  homepage "https://github.com/professoroakz/.github"
  url "https://github.com/professoroakz/.github/archive/refs/tags/v1.3.37.tar.gz"
  sha256 "" # To be filled when creating actual releases
  license "MIT"

  depends_on "node"

  def install
    # Install npm package globally
    system "npm", "install", "-g", "@professoroakz/github"
    
    # Copy documentation
    doc.install "README.md"
    
    # Install profile and settings directories
    (prefix/"profile").install Dir["profile/*"] if File.directory?("profile")
    (prefix/"settings").install Dir["settings/*"] if File.directory?("settings")
  end

  test do
    # Test that the package loads successfully
    system "node", "-e", "require('@professoroakz/github'); console.log('Package loads successfully');"
  end

  def caveats
    <<~EOS
      The @professoroakz/github configuration package has been installed.
      
      Profile files are available at:
        #{prefix}/profile
      
      Settings files are available at:
        #{prefix}/settings
      
      You can also use the npm package directly in Node.js:
        const github = require('@professoroakz/github');
    EOS
  end
end
