# Deploying the Application

This article will guide you through the deployment process of this application.

## Assumptions

For this documentation, we will assume that you are running an Ubuntu box, something like 14.04.x, with the following software installed:

- [NGINX](http://nginx.org) (Webserver)
- [Phusion Passenger](https://www.phusionpassenger.com) (Webserver extension)
- [Git](http://git-scm.org)

## The First Steps

You'll want to decide exaclty where on your server you want to host the files for the application. Typically, for a website, files will be hosted in the `/var/www` directory. Once you've decided on a directory, `cd` into it.

Next, you'll want to clone this repository to your server, that can be done using the following command:

```bash
$ git clone git@github.com:gunnar94/online-courses.git
```

You should now have the source code sitting on your server, in the location of your choosing. Next we'll configure the webserver.

## Time to Generate Some Keys

Change into the directory you just cloned, run the following three command, and then **DON'T FORGET** their output!

```bash
$ pwd
```

```bash
$ rake secret
```

```bash
$ 
```

## Get the Server Running

### Finding the Configuration Files

First of all, we'll need to figure out where your NGINX configuration files are located. You can do that with the following command:

```bash
nginx -V
```

It is important that you use an uppercase `V`!

After that command executes, look for a directory prefixed by `--prefix=`. This path is the one we want. Depending on how you installed NGINX, you might need to add `/conf` to the end of that path.

### Adding Application Specific Config

This configuration isn't too complicated, here it is:

```nginx
server {
    listen 80;
    root PATH_TO_PUBLIC;
    passenger_enabled on;
    rails_env production;

    passenger_env_var SECRET_KEY_BASE APP_KEY_HERE;
    passenger_env_var DEVISE_SECRET_KEY DEVISE_KEY_HERE;
}
```

In the above configuration file, you'll notice a few placeholders. You'll need to replace these.

Remember when I said to remember the directory you cloned the source code into? You'll need to replace `PATH_TO_PUBLIC` with the fully qualified path to that directory, **PLUS** you'll need to add `/public` onto the end.

For example, if you cloned into `/var/www/online-courses`, you will replace the placeholder with `/var/www/online-courses/public`.

