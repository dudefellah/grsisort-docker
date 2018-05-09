# Dockerizing Grsisort

As of right now, this is just an experiment at creating a docker image for
grsisort in order to facilitate running multiple jobs in some kind of
clustered environment. I'm placing it on Github because I can see this
potentially being of use to someone else.

# Building the Image

Build the actual image like any other Docker image:

```bash
$ docker build .
```

A full list of docker build options are available [here](https://docs.docker.com/engine/reference/commandline/build/).
