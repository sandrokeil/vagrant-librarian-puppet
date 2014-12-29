include nginx

node default {
    hiera_include('classes','')

    $packages = [
        'vim',
        'htop'
    ]
    package {$packages: ensure => present}

    nginx::resource::vhost { "puppetdemo.dev":
        ensure               => present,
        server_name          => ['puppetdemo.dev'],
        listen_port           => 80,
        www_root              => "/vagrant/public",
        proxy                 => undef,
        location_cfg_append   => undef
    }

    nginx::resource::location { "puppetdemo_root":
        ensure          => present,
        vhost           => "puppetdemo.dev",
        www_root        => "/vagrant/public",
        location        => '~ \.php$',
        index_files     => ['index.php', 'index.html', 'index.htm'],
        proxy           => undef,
        fastcgi         => "127.0.0.1:9000",
        fastcgi_script  => undef,
        location_cfg_append => {
            fastcgi_connect_timeout => '3m',
            fastcgi_read_timeout    => '3m',
            fastcgi_send_timeout    => '3m'
        }
    }
}
