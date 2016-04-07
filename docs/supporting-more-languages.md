# Supporting More Languages

With the Docker container, you have the ability to support any software which will run on Ubuntu. To add support for additional languages, one must edit the `Dockerfile` file located in the root directory of this application.

## Editing the Dockerfile

Information regarding editing the `Dockerfile` is provided by [Digital Ocean](https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images).

Once you've edited the `Dockerfile`, you'll need to rebuild the Docker container image, the next section will describe this process.

## Rebuilding the Image

Once you've made all necessary changes to the `Dockerfile`, you need to rebuild the image. The following command will do this for you:

```bash
$ bin/docker_setup
```

Now restart the grader by running the following:

```bash
$ sudo bin/delayed_job restart
```
