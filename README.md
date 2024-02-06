# WordPress Docker Compose Setup

This a local development setup that allows you to run a WordPress easily using `docker compose`. This is basically an alternative to using MAMP to quickly spin up a site on your local.

**Requirements**:

1. [Docker](https://www.docker.com/)

## Setup

1. Download your FULL (WordPress core included) WordPress website and put it into the `./site` directory.
2. Update the `wp-config.php` to have the following database connection information:
```php
// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wordpress' );

/** Database password */
define( 'DB_PASSWORD', 'wordpress' );

/** Database hostname */
define( 'DB_HOST', 'database' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );
```
3. Download a copy of the WordPress database and put it in the `./docker/initdb/` folder (it can have a `.gz` extension if you want to save space)
4. Build the WordPress Docker image by running `docker compose build --no-cache`
5. Bring up the services with `docker compose up -d`
6. Your site should appear at [http://localhost](http://localhost)

## Tips and Tricks

Note: Depending on your setup you may need to go into the [phpMyAdmin service](http://localhost:4000/) and update the `wordpress` database `options` table. The two options you would need to update are `siteurl` and `home` - these may need to be set to `http://localhost` but it may work fine without changing it.

You may want to implement a `wp-config-local.php` file rather than directly changing the database settings in your `wp-config.php` file. To do this, simply add the following line to your `wp-config.php` (this can be committed to source control if you choose since it checks if the file exists before loading it's content):

```php
// Load local configuration if it exists
if (file_exists(__DIR__ . '/wp-config-local.php')) {
    require_once __DIR__ . '/wp-config-local.php';
}
```

You can then override any settings you want to in the `wp-config-local.php` file. As an example, you can override the options `siteurl` and `home` from this file instead of changing them in the database with the following settings:

```php
// Override siteurl and home options
define('WP_SITEURL', 'http://localhost');
define('WP_HOME', 'http://localhost');
```

## Changing PHP Version

If you want to update the PHP version, do the following steps:

1. Ensure your services are not running by using `docker compose down`
2. Replace every instance of `8.2` in the `./Dockerfile` and `./docker/nginx/nginx.conf` files
3. Run `docker compose build --no-cache` to build the image with the new PHP version
4. Spin up your services with `docker compose up -d`