name "secure-pypiserver-cookbook"
maintainer "mattjmorrison"
maintainer_email "mattjmorrison@mattjmorrison.com"
licence "MIT"
description "Installs pypiserver behind SSL and Basic Auth"
version "0.0.1"
recipe "pypiserver", "Installs pypiserver behind SSL and Basic Auth"
supports "ubuntu"

%w{ apt build-essential git nginx ohai pypiserver python runit  }.each do |cb|
  depends cb
end
