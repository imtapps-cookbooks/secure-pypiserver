define :pypiserver do
  include_recipe "nginx"

  template "#{node.nginx.dir}/sites-available/pypiserver" do
    source "pypiserver.erb"
    cookbook 'secure-pypiserver-cookbook'
    owner "root"
    group "root"
    mode 0644
    variables({
      :server_name => "pypi.imtapps.com",
      :auth_basic_file => "/.htpasswd",
      :ssl_key => "/etc/nginx/cert.key",
      :ssl_cert => "/etc/nginx/cert.pem",
    })
  end

  cookbook_file "#{node.nginx.dir}/.htpasswd" do
    source ".htpasswd"
    owner "root"
    group "root"
    mode 0644
  end

  cookbook_file "#{node.nginx.dir}/cert.pem" do
    source "cert.pem"
  end

  cookbook_file "#{node.nginx.dir}/cert.key" do
    source "cert.key"
  end

  nginx_site "pypiserver" do
    action :enable
  end

end
