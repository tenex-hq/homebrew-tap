class Kaibo < Formula
  desc "kaibo: a typed CLI interface to a git-backed markdown knowledge corpus, for AI coding agents."
  homepage "https://github.com/tenex-hq/kaibo"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.4.0/kaibo-aarch64-apple-darwin.tar.xz"
      sha256 "49d92c7de64b1a1e6943b09deda4cb78611b6132440df399a2dfef9c9fa4e7f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.4.0/kaibo-x86_64-apple-darwin.tar.xz"
      sha256 "492f748b866a3fc2f43f41b1c1bc4ac3f1e6f0fcd47c70752940aaba8649deeb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.4.0/kaibo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "431f8bcca9e431c580d160e2389392dc8b4eca641eccc8077504f5b4c259070c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.4.0/kaibo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "df60257fc9c00efa55a974a61fa2831d8a94fe4f5cce7b72f1a1eb101a302812"
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
