class Switters < Formula
  homepage "https://github.com/jkubicek/switters"
  url "https://github.com/jkubicek/Switters/archive/0.1.2.tar.gz"
  sha1 "de75246b72f46e151beef42adb7eb9d6137086f7"
  version "0.1.2"
  depends_on :python if MacOS.version <= :snow_leopard
  
  resource "tweetpony" do
  	url "https://pypi.python.org/packages/source/T/TweetPony/tweetpony-1.5.0.tar.gz"
  	md5 "37e8822be811e7220a80ebb43ccdeb19"
  end
  
  resource "qrcode" do
  	url "https://pypi.python.org/packages/source/q/qrcode/qrcode-5.1.tar.gz"
  	md5 "1f20223419bbf992208ada0c12ed4577"
  end
  
  resource "requests" do
  	url "https://pypi.python.org/packages/source/r/requests/requests-2.5.1.tar.gz"
  	md5 "c270eb5551a02e8ab7a4cbb83e22af2e"
  end

  def install
	ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[tweetpony qrcode requests].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec
    
	libexec.install Dir["switterslib"]
	libexec.install Dir["zxing"]
	libexec.install Dir["zxing_java"]
	bin.install "switters"

    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/switters", "-v"
  end
end
