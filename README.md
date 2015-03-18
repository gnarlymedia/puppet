## Puppet automated WordPress deployment framework

This is a framework I have developed to automate the deployment of WordPress websites on my VPS hosting.

With one line of code, I can install Apache, MySQL and PHP on an agent node, make sure all required dependencies are present, and create a new WordPress site complete with Apache vhost configuration and all plugins and themes up-to-date.

It requires a standard puppet setup with master and at least one agent, as outlined on the PuppetLabs website at https://puppetlabs.com.

These files are designed to be placed in the '/etc/puppet' folder on the puppet master, a standard Ubuntu 14 installation. You will also need to create the file 'modules/my_wordpress/manifests/conf.pp', based on the included file 'modules/my_wordpress/manifests/conf.pp-template', and populate it with your preferred defaults for the installation of WordPress instances.

Also makes use of the excellent puppet module 'hunner/puppet-wordpress', available at https://github.com/hunner/puppet-wordpress.
