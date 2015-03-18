define my_wordpress::core_install (
    $site_title,
    $admin_user,
    $admin_password,
    $admin_email,
    $host = $title,
    $root_directory = "/var/www/",
    $user = "root",
) {
    $slash = "/"
    $wp_cli = "/usr/bin/wp-cli --allow-root"
    $install_dir = "${root_directory}${host}"
    $install_url = $host

    # Install the WP database tables, unless they already exist.
    exec {
	"Install_WP_core_for_${host}":
        command => "$wp_cli core install --url=$install_url --title=$title --admin_user=$admin_user --admin_password=$admin_password --admin_email=$admin_email",
        unless => "$wp_cli core is-installed",
        cwd => $install_dir,
        user => $user
    }
}
