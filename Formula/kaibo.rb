class Kaibo < Formula
  desc "kaibo: a typed CLI interface to a git-backed markdown knowledge corpus, for AI coding agents."
  homepage "https://github.com/tenex-hq/kaibo"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.3.0/kaibo-aarch64-apple-darwin.tar.xz"
      sha256 "85914e3a02639b03140fb86a33dff2ccc87d882dcd0f3a38fe089217172d317f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.3.0/kaibo-x86_64-apple-darwin.tar.xz"
      sha256 "03576110a8b8a99ef5192d6d3317bc6fd315a54787b2b5d009088d0c8cf9fffb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.3.0/kaibo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "64e896d635abc84c60bbf84bb0aa7e2dfdf3a90ba080d82fff5162521cca852c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.3.0/kaibo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5b00106a1d14ad70252c3bd97016c00180f0fb86c5ac0e8e822585da355bff93"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "kaibo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kaibo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kaibo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kaibo"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
