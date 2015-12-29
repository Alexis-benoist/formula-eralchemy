class Eralchemy < Formula
  homepage "https://github.com/Alexis-benoist/eralchemy"
  url "https://pypi.python.org/packages/source/E/ERAlchemy/ERAlchemy-1.0.0.tar.gz"
  sha256 "1feee184852f66a8bfc386474ef9a1ae68f1bb6d773e7bf6c421df8b769abe39"

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on "graphviz"
  depends_on "pkg-config" => :build

  resource "pygraphviz" do
    url "https://pypi.python.org/packages/source/p/pygraphviz/pygraphviz-1.3.1.tar.gz"
    sha256 "7c294cbc9d88946be671cc0d8602aac176d8c56695c0a7d871eadea75a958408"
  end

  resource "SQLAlchemy" do
    url "https://pypi.python.org/packages/source/S/SQLAlchemy/SQLAlchemy-1.0.11.tar.gz"
    sha256 "0b24729787fa1455009770880ea32b1fa5554e75170763b1aef8b1eb470de8a3"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[pygraphviz SQLAlchemy].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
  test do
     system "#{bin}/eralchemy", "-v"
  end
end
