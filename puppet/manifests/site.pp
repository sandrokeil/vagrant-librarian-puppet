node default {
    hiera_include('classes','')

    $packages = [
        'vim',
        'htop'
    ]
    package {$packages: ensure => present}
}
