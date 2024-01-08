class PythonTroveClassifiers < Formula
  desc "Canonical source for classifiers on PyPI"
  homepage "https://github.com/pypa/trove-classifiers"
  url "https://files.pythonhosted.org/packages/44/e4/9de7cda4a03a996758fbdb7ddacc071b4c62fdcd645e0a1192a22e8c55c0/trove-classifiers-2024.1.8.tar.gz"
  sha256 "6e36caf430ff6485c4b57a4c6b364a13f6a898d16b9417c6c37467e59c14b05a"
  license "Apache-2.0"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "210a0d58c2192f37bc7d216f23ffa8475c270980743b1e07fbe2055163c5b97d"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "dd4c9e9dc2137c45c9bc825c6aeb1f14cb10c1e74170a95f151d6793d53711d9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "663ef236a67063d9cc4f5f768bb1a3862d298cde1644974e85c315abfe0ebb4d"
    sha256 cellar: :any_skip_relocation, sonoma:         "a7b92efc5654750d3d0ee700bc6c007060747d1ee1aa47a61b8ad5496300e176"
    sha256 cellar: :any_skip_relocation, ventura:        "55800164b1c103e86015495aea980227c4e8efa9f0cac57f5f6a9ec68a6379e1"
    sha256 cellar: :any_skip_relocation, monterey:       "c801c605586ce30ace4e555fbc8b7ef28d7b78d072e0231f0d0101ebb4fc903a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ff50e6bb985fadfbdcd018f36ebeb6f4e74407ac90860faa027217ab4e63396b"
  end

  depends_on "python-setuptools" => :build
  depends_on "python@3.11" => [:build, :test]
  depends_on "python@3.12" => [:build, :test]

  def pythons
    deps.map(&:to_formula).sort_by(&:version).filter { |f| f.name.start_with?("python@") }
  end

  def install
    pythons.each do |python|
      python_exe = python.opt_libexec/"bin/python"
      system python_exe, "-m", "pip", "install", *std_pip_args, "."
    end
  end

  test do
    pythons.each do |python|
      python_exe = python.opt_libexec/"bin/python"
      classifiers = shell_output("#{python_exe} -m trove_classifiers")
      assert_match "Environment :: MacOS X", classifiers
    end
  end
end
