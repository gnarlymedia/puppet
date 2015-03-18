# This file is based in part on the page "How to Use Puppet to Manage WordPress Themes and Plugins on Ubuntu 14.04" by Digital Ocean at https://www.digitalocean.com/community/tutorials/how-to-use-puppet-to-manage-wordpress-themes-and-plugins-on-ubuntu-14-04

define my_wordpress::resource (
	$host,
    	$resource_name,
    	$resource_type,
    	$root_directory = "/var/www/",
    	$action,
    	$user = "root",
) {
    	$wp_cli = "/usr/bin/wp-cli --allow-root"
	$install_dir = "${root_directory}${host}"

    # Install the theme or plugin unless it is already installed.
    if $action == "install" {
        exec { "Install $resource_name":
            command => "$wp_cli $resource_type $action $resource_name",
            unless => "$wp_cli $resource_type is-installed $resource_name",
            cwd => $install_dir,
            user => $user
        }
    }

    # Activate or update the theme or plugin only if it is currently installed.
    if $action == "activate" or $action == "update" {
	if $resource_name == "all" and $action == "update" {
		exec {
			"${title}":
            		command => "$wp_cli $resource_type $action --all",
            		cwd => $install_dir,
            		user => $user
        	}
	} else {
        	exec {
			"$action $resource_name":
            		command => "$wp_cli $resource_type $action $resource_name",
            		onlyif => "$wp_cli $resource_type is-installed $resource_name",
            		cwd => $install_dir,
            		user => $user
        	}

   	}
    }

    # Uninstall or deactivate a plugin only if it is currently installed.
    if $resource_type == "plugin" {
        if $action == "uninstall" or $action == "deactivate" {
            exec { "$action $resource_name":
                command => "$wp_cli plugin $action $resource_name",
                onlyif => "$wp_cli plugin is-installed $resource_name",
                cwd => $install_dir,
                user => $user
            }
        }
    }

    # Delete a theme only if it is currently installed.
    if $action == "delete" and $resource_type == "theme" {
        exec { "$action $resource_name":
            command => "$wp_cli theme $action $resource_name",
            onlyif => "$wp_cli theme is-installed $resource_name",
            cwd => $install_dir,
            user => $user
        }
    }
}
