class Dhub < Formula
  desc "Directory Hub - Quick directory navigation tool"
  homepage "https://github.com/fcartolano/dhub"
  version "1.0.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/fcartolano/dhub/releases/download/v1.0.0/dhub-darwin-arm64"
      sha256 "0b0670682f13f5af00019af24e614da29bf7403e2b9c3ccfb109205f2eee0387"

      def install
        bin.install "dhub-darwin-arm64" => "dhub"
        prefix.install "bash_integration.sh"
        prefix.install "zsh_integration.sh"
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/fcartolano/dhub/releases/download/v1.0.0/dhub-darwin-amd64"
      sha256 "9f9927183e9f91df94ab2c2bf78c999de995cb28ada49e40eb8932cf8e5724dd"

      def install
        bin.install "dhub-darwin-amd64" => "dhub"
        prefix.install "bash_integration.sh"
        prefix.install "zsh_integration.sh"
      end
    end
  end

  def caveats
    <<~EOS
      To enable dhub, add the following to your shell configuration file:
      
      For Bash users (add to ~/.bash_profile or ~/.bashrc):
        source #{prefix}/bash_integration.sh
      
      For Zsh users (add to ~/.zshrc):
        source #{prefix}/zsh_integration.sh
      
      You can also create a directory for dhub integration scripts:
        mkdir -p ~/.dhub
        cp #{prefix}/bash_integration.sh ~/.dhub/
        cp #{prefix}/zsh_integration.sh ~/.dhub/
        
      And then source from there:
        source ~/.dhub/bash_integration.sh  # For Bash
        source ~/.dhub/zsh_integration.sh   # For Zsh
    EOS
  end

  def post_install
    dhub_dir = Pathname.new("#{ENV["HOME"]}/.dhub")
    dhub_dir.mkpath unless dhub_dir.exist?
    
    # Copy integration scripts to ~/.dhub/
    cp "#{prefix}/bash_integration.sh", "#{ENV["HOME"]}/.dhub/"
    chmod 0755, "#{ENV["HOME"]}/.dhub/bash_integration.sh"
    
    cp "#{prefix}/zsh_integration.sh", "#{ENV["HOME"]}/.dhub/"
    chmod 0755, "#{ENV["HOME"]}/.dhub/zsh_integration.sh"
    
    # Detect shell and add appropriate source command if not already present
    shell = ENV["SHELL"]
    
    if shell.include?("zsh") && File.exist?("#{ENV["HOME"]}/.zshrc")
      unless File.read("#{ENV["HOME"]}/.zshrc").include?("source ~/.dhub/zsh_integration.sh")
        File.open("#{ENV["HOME"]}/.zshrc", "a") do |file|
          file.puts "\n# dhub CLI tool integration"
          file.puts "source ~/.dhub/zsh_integration.sh"
        end
        opoo "Added dhub integration to ~/.zshrc"
      end
    elsif File.exist?("#{ENV["HOME"]}/.bash_profile")
      unless File.read("#{ENV["HOME"]}/.bash_profile").include?("source ~/.dhub/bash_integration.sh")
        File.open("#{ENV["HOME"]}/.bash_profile", "a") do |file|
          file.puts "\n# dhub CLI tool integration"
          file.puts "source ~/.dhub/bash_integration.sh"
        end
        opoo "Added dhub integration to ~/.bash_profile"
      end
    end
  end

  test do
    # Test the basic command functionality
    assert_match "Directory Hub", shell_output("#{bin}/dhub")
    # Cannot test goto functionality as it needs shell integration
  end
end

