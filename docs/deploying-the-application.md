# Deploying the Application

This article will guide you through the deployment process of this application, it will not instruct you on how to install the needed operating system, web server, web server extensions, ect.

## Assumptions

This document is written assuming that you have experience with, and have already installed the following:

- [Ubuntu Server 14.04.x](http://www.ubuntu.com/server) (Operating system)
- [NGINX 1.8.x](http://nginx.org) (Web server)
  - [Phusion Passenger 5.0.x](https://www.phusionpassenger.com) (NGINX extension)
- [Git](http://git-scm.org) (Source control)
- [Ruby 2.3.x](http://ruby-lang.org) (Programming language)
- [Ruby on Rails 4.2.x](http://rubyonrails.org) (Web framework)
- [MySQL 14.14](https://www.mysql.com) (Database)
- [Docker 1.10.x](https://www.docker.com) (Linux container manager)

In addition to the previous assumptions, it will also be assumed that you are deploying in your production environment, and that you have `sudo` access. If you are developing, it is recommended that you do so locally, using Ruby on Rail's built in WEBrick web server.

## Installation

Once you've cloned the application's source to your server, you are ready to install the application. To do this, a fancy script exists to do the work for you! Simply run `bin/install` from the application's root directory. This script may take a few minutes to do all that it needs to. Once it's done, move on to the next section.

## Modify the Docker Initialization Script

This application makes use of Docker's REST API. This API, however, is not started by the default init script. You must modify the init script `/etc/init/docker.conf` to include the following:

```conf
DOCKER_OPTS='-H tcp://0.0.0.0:4243 -H unix:///var/run/docker.sock'
```

You should see a line which looks something like `DOCKER_OPTS=''`, replace that line with what's above.

## Configuration

In the `config` directory, you should see a file named `private.yml`. It was created by the install script. Right now, it should contain the default configuration. You will need to update these values, setup the web server, and setup your Docker image.

Read through the following sections to learn how to configure your application.

### Web Server (NGINX)

```nginx
server {
  listen 80;

  root APP_ROOT/public;

  passenger_enabled on;

  rails_env production;
}
```

You will need to change `APP_ROOT` to be the fully qualified name of the directory you cloned the application's into.

### Docker Image

Learn how to [support more languages](supporting-more-languages.md) with the Docker image.

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

### Grader

```yaml
grader:
  timeout: 20
  max_bytes: 1024
```

`timeout` describes the maximum amount of time in seconds a student's code will be run for. The `max_bytes` value describes the point at which the stdout and/or stderr output from a student's program will be truncated.

### Uploads

```yaml
uploads:
  location: '/uploads'
```

## Final Touches

Now that the application is installed and configured, you are ready to run it. Do to this, restart your web server, then open up a browser and navigate to the application.

You can now move onto [starting the application](starting-the-application.md).
