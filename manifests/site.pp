#Distcc class
class distcc {
	#Packages to install 
	package { 'distcc': ensure => "installed" }
	package { 'ccache': ensure => "installed" }
	package { 'distcc-pump': ensure => "installed" }
	package { 'build-essential': ensure => "installed" }
	package { 'kernel-package': ensure => "installed" }

	configfile { "/etc/default/distcc":
		source => "/etc/puppet/configs/distcc/distcc",
		mode => 644,
		require => Package["distcc"],
	}

	service { "distcc":
		enable => "true",
		ensure => "running,
		notify  => Service["distcc"],
	}
}	

# tell puppet on which client to run the class
node domu-12-31-39-01-5e-1b {
    include distcc
}
