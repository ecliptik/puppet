#Distcc class
class distcc {
	#Packages to install 
	package { 'distcc': ensure => "installed" }
	package { 'ccache': ensure => "installed" }
	package { 'distcc-pump': ensure => "installed" }
	package { 'build-essential': ensure => "installed" }
	package { 'kernel-package': ensure => "installed" }

	file { "distcc":
		path => "/etc/default/distcc",
		source => "puppet:///files/distcc/distcc",
		mode => 644,
		owner => root,
		group => root,
	}

	service { "distcc":
		enable => "true",
		ensure => "true",
		hasstatus => "true",
		hasrestart => "true",
		subscribe  => File["/etc/default/distcc"],
		require => package["distcc"],
	}
}	

class aptupdate {
	exec { "apt-get update":
	command => "/usr/bin/apt-get update",
	onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}
}

# tell puppet on which client to run the class
node ip-10-28-187-123 {
    include distcc
    include aptupdate
}

