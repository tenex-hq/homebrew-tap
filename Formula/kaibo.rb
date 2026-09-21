class Kaibo < Formula
  desc "kaibo: a typed CLI interface to a git-backed markdown knowledge corpus, for AI coding agents."
  homepage "https://github.com/tenex-hq/kaibo"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.2.0/kaibo-aarch64-apple-darwin.tar.xz"
      sha256 "5930345d928edf7c647d22ab1a1725a28705c39d346d0caeb38522dff9ed79fd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.2.0/kaibo-x86_64-apple-darwin.tar.xz"
      sha256 "dc8ebe3833a7095eec59bb9e8cc45b4493fa5a6d5015eec625883327cb6161b7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.2.0/kaibo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4aa418d4ae029e1c0225655ccf420752458501a0baf5770a962d0d68b3aca453"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tenex-hq/kaibo/releases/download/v0.2.0/kaibo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0b5d89df1645f769d2d78d64ea65f3553fd8a123ab73139eed2d553c9a969727"
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
