
define :pypiserver do
  nginx_dir = params[:nginx_dir]
  server_name = params[:server_name]
  ssl_key = params[:ssl_key]
  ssl_crt = params[:ssl_crt]
  auth_basic_file = params[:passwd_file]

  node.pypiserver.passwd_file = "#{nginx_dir}/#{auth_basic_file}"

  include_recipe "pypiserver"
  include_recipe "nginx"

  template "#{nginx_dir}/sites-available/pypiserver" do
    source "pypiserver.erb"
    cookbook 'secure-pypiserver'
    owner "root"
    group "root"
    mode 0644
    variables({
      :server_name => server_name,
      :auth_basic_file => "#{nginx_dir}/.htpasswd",
      :ssl_key => "#{nginx_dir}/cert.key",
      :ssl_cert => "#{nginx_dir}/cert.pem",
    })
  end

  cookbook_file "#{nginx_dir}/.htpasswd" do
    source auth_basic_file
    owner "root"
    group "root"
    mode 0644
  end

  cookbook_file "#{nginx_dir}/cert.pem" do
    source ssl_crt
  end

  cookbook_file "#{nginx_dir}/cert.key" do
    source ssl_key
  end

  nginx_site "pypiserver" do
    enable true
  end

  nginx_site "default" do
    enable false
  end

end
