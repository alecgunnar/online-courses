# Starting the Application

Most of the work required to get the application running is handled by the webserver, however there is one thing you must do -- start the job backend.

To start the job backend, run the following command from the application's root directory.

```bash
$ sudo bin/delayed_job start
```

This will start a daemon, the daemon must be running at all times for the application to function properly. If gradding suddenly stops, check to make sure this daemon is still running properly by running the following:

```bash
$ sudo bin/delayed_job status
```

If the output of that command is anything other than, something like this:

```bash
delayed_job: running [pid 30914]
```

Restart the job backend, like so:

```bash
sudo bin/delayed_job restart
```


