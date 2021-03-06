class agorabase::apache 
{      
    package 
    { 
        "apache2":
            ensure  => present,
            require => [Exec['apt-get update'], Package['php5'], Package['php5-dev'], Package['php5-cli']]
    }
    
    service 
    { 
        "apache2":
            ensure      => running,
            enable      => true,
            require     => Package['apache2'],
            subscribe   => [
                File["/etc/apache2/mods-enabled/rewrite.load"],
                File["/etc/apache2/conf-enabled/phpmyadmin.conf"]
            ],
    }

    file 
    { 
        "/etc/apache2/mods-enabled/rewrite.load":
            ensure  => link,
            target  => "/etc/apache2/mods-available/rewrite.load",
            require => Package['apache2'],
    }

    exec 
    { 
        'echo "ServerName localhost" | sudo tee /etc/apache2/conf-enabled/fqdn.conf':
            require => Package['apache2'],
    }
}