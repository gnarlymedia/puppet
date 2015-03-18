node 'shared4' {
	$node = 'shared4'

	class {
		'my_wordpress::app':
        }

        $doc_root = "/var/www"

        apache::vhost {
                "my_default":
                port            => '80',
                docroot         => "${doc_root}",
                default_vhost   => true,
                require => Class[
                        'my_wordpress::app'
                ]        
	}

#	my_wordpress::instance {
#		'example18.com':
#	}

#	my_wordpress::instance {
#		'example19.com':
#	}

#	my_wordpress::instance {
#		'example20.com':
#	}
	my_wordpress::instance {
		'example21.com':
	}
	my_wordpress::instance {
		'example22.com':
	}
	my_wordpress::instance {
		'example23.com':
	}
}
