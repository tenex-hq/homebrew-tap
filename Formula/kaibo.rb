class Kaibo < Formula
  desc "kaibo: a typed CLI interface to a git-backed markdown knowledge corpus, for AI coding agents."
  homepage "https://github.com/tenex-hq/kaibo"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.1.0/kaibo-aarch64-apple-darwin.tar.xz"
      sha256 "6b8f8c608e6ad941b0550a3c555715967b98b8374e5535000558790fc0dd9c1f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.1.0/kaibo-x86_64-apple-darwin.tar.xz"
      sha256 "f6643b2ea3dd17908781a31b8fff2e156318cf46ede3b25d725662eae25fb0ca"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.1.0/kaibo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0f5d1bf600b0fd092789a7aa8be681641ca7d2cf2f3882d0ced6b640e18fe480"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.1.0/kaibo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "22a982074ed39033f606899944c016413722cd9b6c09ea4645a5dde3413068a9"
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
