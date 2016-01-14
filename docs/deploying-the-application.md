# Deploying the Application

This article will guide you through the deployment process of this application.

## Assumptions

For this documentation, it is assumed that you are running an Ubuntu box, with the following software installed:

- [NGINX](http://nginx.org) (Webserver)
  - [Phusion Passenger](https://www.phusionpassenger.com) (NGINX extension)
- [Git](http://git-scm.org) (Source control)
- [Ruby](http://ruby-lang.org) (Programming language)
- [Ruby on Rails](http://rubyonrails.org) (Web framework)

This documentation will also assume that you are deploying in your production environment and that you have `sudo` access. If you are developing, It is recommend that you do so locally, using `rails server`, you should still read the [application configuration](#application-configuration) section, however.

## The First Steps

Firstly, you'll want to decide on exaclty where you'd like to host the files for the application. Typically, for a website, files will be hosted in the `/var/www` directory. Regardless of which directory you decide on, `cd` into the directory.

Next, you'll want to clone this repository to your server. That can be done using the following command:

```bash
$ git clone git@github.com:WMU-Online-Courses/online-courses.git
```

You should now have the source code sitting on your server, and you'll now want to `cd` into the directory git clone created.

## Application Configuration

Our next big step towards deploying the application is the configuration of the application itself.

In the application directory structure, you should see a `config` directory. In that directory, we need to create a file called `private.yml`.

This can be done by making a copy of the distribution version of the file. Run the following from the root of the project:

```bash
$ cp config/private.yml.dist config/private.yml
```

One you have created the config file, open it so that we may edit in needed secret keys next.

### Application Secret Keys

For the sake of security, Ruby on Rails and Devise both require secret keys for the application to function properly. You will need to generate your own secret keys for your deployment.

To generate a secret key, run the following (again from the project's root directory):

```bash
$ rake secret
```

This command will generate only one secret key, so you'll need to run it twice. Once you have both of the keys, you should place them in the file, by replacing the existing keys provided by the distribution configuration file. Once you're done save the file.

### Final Setup

To finalize the setup of your application, run the following:

```bash
$ ./bin/setup
```

This command will install all needed gems, then create and seed the database.

## Get the Server Running

### Finding the Configuration Files

If you are unfamiliar with the configuration of NGINX, I'll tell you how to find the configuration files next. To determine the location of your NGINX configuration files, run the following:

```bash
nginx -V
```

*It is important that you use an uppercase `V`!*

After that command executes, look for a path prefixed by `--prefix=`. This path is the one we want. Depending on how you installed NGINX, you might need to add `/conf` to the end of that path.

### The Application Specific Server Config

This configuration isn't too complicated, here it is:

```nginx
server {
    listen 80;
    root <PATH TO PUBLIC>;
    passenger_enabled on;
    rails_env production;
}
```

In the above configuration file, you'll notice a placeholder that needs replacing.

Remember when I said to not forget the directory you cloned the source code into? You'll need to replace `<PATH TO PUBLIC>` with the fully qualified path to that directory, **PLUS** you'll need to add `/public` onto the end of that path.

For example, if you cloned into `/var/www/online-courses`, you will replace the placeholder with `/var/www/online-courses/public`.

Just to be quick about placing this configuration, unless you're aware of a better way (sites-available/enabled), place this config in the http block of the `nginx.conf` file in the NGINX config directory.

### Restart the Webserver

Anytime you edit NGINX configuration files, you should restart the webserver. Run the following:

```bash
$ sudo nginx -s reload
```

If that does not work, run the following two commands instead:

```bash
$ sudo kill -9 $(fuser 80/tcp)
$ sudo nginx
```