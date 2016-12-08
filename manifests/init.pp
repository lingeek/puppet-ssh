#This is the class for manageing SSH

class ssh (
jgjg
#This value is in SuSe.yaml/eb3
$sshd_package             = hiera('sshd_package'),
$service_name             = hiera('sshd::service'),
#END

$sshd_package_status      = hiera('sshd_package_status'),
$sshd_port                = hiera('sshd_port'),
$sshd_listen              = hiera('sshd_listen'),
$sshd_path                = hiera('sshd_path'),
$sshd_service_ensure      = hiera('sshd::service_ensure'),
$sshd_service_enable      = hiera('sshd::service_status'),
$sshd_challenge_response  = hiera('sshd::challenge_response'),
$sshd_pam                 = hiera('sshd::use_pam'),
$sshd_protocol            = hiera('sshd_protocol'),
$sshd_keyfile             = hiera('sshd_keyfile'),
$sshd_pass_auth           = hiera('sshd::pass_auth'),
$sshd_log_level           = hiera('sshd::log_level'),
$sshd_x11_forwarding      = hiera('sshd::x11_forwarding'),
$sshd_ignore_rhosts       = hiera('sshd::ignore_rhosts'),
$sshd_max_auth            = hiera('sshd::max_auth'),
$sshd_host_based          = hiera('sshd:host_based_auth'),
$sshd_permit_root         = hiera('sshd::permit_root'),
$sshd_permit_empty        = hiera('sshd::permit_empty'),
$sshd_permit_user         = hiera('sshd:permit_user'),
$sshd_ciphers             = hiera('sshd::ciphers'),
$sshd_client_interval     = hiera('sshd::client_interval'),
$sshd_client_max          = hiera('sshd::client_max'),
$sshd_banner              = hiera('sshd::banner'),

#This value is in common.yaml
$file                     =hiera('file::file'),
#END

) 


{
package { $sshd_package:
    ensure => $sshd_package_status,
  }


service { $service_name:
    ensure    => $sshd_service_ensure,
    enable    => $sshd_service_enable,
    name      => $service_name,
    hasstatus => true,
    require   => [
                  Package["$sshd_package"],
                  File["$sshd_path"],


],
  }


file { $sshd_path:
  ensure  => $file,
  content => template('ssh/sshd_config.erb'),
  require => Package["$sshd_package"],
  notify => Service["$service_name"],

}

}

