# Deploying the Application

This article will guide you through the deployment process of this application, it will not instruct you on how to install the needed operating system, web server, web server extensions, ect.

## Assumptions

This document is written assuming that you have experience with, and have already installed the following:

- [Ubuntu Server](http://www.ubuntu.com/server) (Operating system)
- [NGINX](http://nginx.org) (Web server)
  - [Phusion Passenger](https://www.phusionpassenger.com) (NGINX extension)
- [Git](http://git-scm.org) (Source control)
- [Ruby](http://ruby-lang.org) (Programming language)
- [Ruby on Rails](http://rubyonrails.org) (Web framework)
- [MySQL](https://www.mysql.com) (Database)
- [Docker](https://www.docker.com) (Linux container manager)

In addition to the previous assumptions, it will also be assumed that you are deploying in your production environment, and that you have `sudo` access. If you are developing, it is recommended that you do so locally, using Ruby on Rail's built in webserver.

## Installation

Once you've cloned the application's source to your server, you are ready to install the application. To do this, a fancy script exists to do the work for you! Simply run `./bin/install` from the application's root directory. This script may take a few minutes to do all that it needs to. Once it's done, move on to the next section.

## Configuration

In the `config` directory, you should see a file named `private.yml`. It was created by the install script. Right now, it should contain only the generic, default configuration. You will need to update these values.

Read through the following sections to learn how to configure your application.

### Database

```yaml
db:
  database: onlinecourses
  username: root
  password: 
  host: localhost
```

The database configuration should be pretty straightforward. Insert the necessary username, password, host, and database name.

### Secure

```yaml
secure:
  key_base: d0b1e8efc664d35a386fdfa3da33df6cc4303294beff4af4d6845d42d2854fcd95312b8bf54194ae4a67870947af195b65462fd9d80ce7da0f069499c97bc9a3
```

This section requires you to generate an installation specific application secret key. To do this, run `rake secret`, and paste the key in place of the default one.

### LTI

```yaml
lti:
  key: ca6f3774db796899f474d1f664d3d963
  secret: 03d5ec7d98abdcb03056ba143ac85b11
```

You will see two keys here, one public (key) and the other private (secret). For each of these fields, you will need to generate a distinct 32 character key. You can again run `rake secret`, then select 32 characters from the generated key to use.

## Final Touches

Now that the application is installed and configured, you are ready to run it. Start by restarting your web server, then open up a browser and navigate to the application.

## Example NGINX Configuration

Here is an example NGINX web server configuration. All you need to change, is the `<PATH TO PUBLIC>` placeholder. As the placeholder suggests, the fully qualified path to the `public` directory of the application on your server needs to go there.

```nginx
server {
    listen 80;
    root <PATH TO PUBLIC>;
    passenger_enabled on;
    rails_env production;
}
```
