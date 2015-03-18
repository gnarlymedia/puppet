define my_wordpress::instance(
	$host = $title,
	$root_directory = "/var/www/",
) {
	$doc_root = "${root_directory}${host}"

	# Create apache vhost
	apache::vhost {
        	"${host}":
        	port    => '80',
        	docroot => $doc_root,
		docroot_owner => "${my_wordpress::conf::docroot_owner}",
  		docroot_group => "${my_wordpress::conf::docroot_group}",
	}

        wordpress::instance {
                "/var/www/${host}":
                wp_owner    		=> "${my_wordpress::conf::docroot_owner}",
                wp_group    		=> "${my_wordpress::conf::docroot_group}",
                db_user     		=> "${host}",
                db_name     		=> "${host}",
                db_password 		=> "${my_wordpress::conf::db_user_password}",
		db_host			=> "${my_wordpress::conf::db_host}",
		version			=> '4.1.1',
		wp_additional_config 	=> 'my_wordpress/wp-config-extra.php.erb',
		require 		=> Apache::Vhost[
                        "${host}"
                ]
        }

        $site_title_complete = "${host}${my_wordpress::conf::site_title_suffix}"

        my_wordpress::core_install {
                "${host}":
                site_title => $site_title_complete,
                admin_user => "${host}",
                admin_password => "${my_wordpress::conf::wp_password}",
                admin_email => "${my_wordpress::conf::admin_email_prefix}@${host}",
                require => Wordpress::Instance [
	                "/var/www/${host}"
                ]
        }

	my_wordpress::resource {
		"Update_plugins_on_${host}":
		host		=> "${host}",
	    	resource_name 	=> "all",
    		resource_type 	=> "plugin",
    		action 		=> "update",
	        require 	=> My_wordpress::Core_install [
                        "${host}"
                ]
	}

        my_wordpress::resource {
                "Update_themes_on_${host}":
		host		=> "${host}",
                resource_name 	=> "all",
                resource_type 	=> "theme",
                action 		=> "update",
                require 	=> My_wordpress::Resource [
                        "Update_plugins_on_${host}"
                ]
        }
}
