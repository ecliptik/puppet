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
		ensure => "running",
		notify  => Service["distcc"],
	}
}	

class aptupdate {
	exec { "apt-get update":
	command => "/usr/bin/apt-get update",
	onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}
}

# tell puppet on which client to run the class
node domu-12-31-39-01-5e-1b {
    include distcc
    include aptupdate
}
