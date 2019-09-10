# HashiConf 2019 - Adopting The Tao of HashiCorp for Application Pipelines: Presentation Assets

This repository contains assets used by Indellient's HashiConf 2019 Presentation: Adopting the Tao of HashiCorp for Application Pipelines.

The repository is split into two sections:

1. `slides` - code snippets, gifs for the slide deck.
2. `demo` - a functioning demo showcasing a Jenkins pipeline for building a Golang Habitat package (with tests) which will run on Nomad.


### Getting the Demo to work:

The following steps can be taken to replicate the demo:

From the `demo` directory,

1. vagrant up
2. vagrant ssh jenkins
3. /srv/bootstrap_jenkins
4. Go to localhost:80 on the host machine, go through the steps to unlock jenkins (see output of previous script), install the recommended plugins and continue as admin
5. Exit out of the script in step 3
6. `docker login`
7. Copy `target` from build of https://github.com/jenkinsci/jenkinsfile-runner to `synced/jenkins`
8. /srv/run_jenkinsfile
9. Go to localhost:8080 (Nomad UI) and add the job defined in `nomad-jobs/golang-hello-world.nomad`.

Adjust the Docker organization uploaded to as necessary.
