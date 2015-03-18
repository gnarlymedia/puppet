class my_wordpress::app {
	class {
		'::mysql::server':
      		# Set the root password
        	root_password => $my_wordpress::conf::root_password,
		# remove_default_accounts => true
    	}

    	# Install MySQL client and all bindings
    	class {
		'::mysql::client':
       		require => Class['::mysql::server'],
       		bindings_enable => true
    	}

	# Install Apache
        class {'apache':
                mpm_module => 'prefork',
                default_vhost => false
        }

        # Add support for PHP
        class {
		'::apache::mod::php':
	}

        # Load all variables
        class {
                'my_wordpress::conf':
        }

	#ensure_packages (
        #	'curl'
	#)

	class {
		'my_wordpress::install_wp_cli':
	}
}
