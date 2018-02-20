# dockerfile-ghe-helper
[![License](https://img.shields.io/github/license/ppouliot/dockerfile-ghe-helper.svg)](./LICENSE)
[![Source Code](https://img.shields.io/badge/source-GitHub-blue.svg?style=flat)](https://github.com/ppouliot/dockerfile-ghe-helper)
[![Latest version](https://img.shields.io/github/tag/ppouliot/dockerfile-ghe-helper.svg?label=release&style=flat&maxAge=2592000)](https://github.com/ppouliot/dockerfile-ghe-helper/tags)
[![GitHub issues](https://img.shields.io/github/issues/ppouliot/dockerfile-ghe-helper.svg)](https://github.com/ppouliot/dockerfile-ghe-helper/issues)
[![GitHub forks](https://img.shields.io/github/forks/ppouliot/dockerfile-ghe-helper.svg)](https://github.com/ppouliot/dockerfile-ghe-helper/network)
[![Docker Automated build](https://img.shields.io/docker/automated/ppouliot/puppet-ipam.svg)](https://hub.docker.com/r/ppouliot/ghe-helper/)
[![Docker Build Status](https://img.shields.io/docker/build/ppouliot/puppet-ipam.svg)]()

```
   ___ _ _   _        _      ___     _                    _          _  _     _               
  / __(_) |_| |_ _  _| |__  | __|_ _| |_ ___ _ _ _ __ _ _(_)______  | || |___| |_ __  ___ _ _ 
 | (_ | |  _| ' \ || | '_ \ | _|| ' \  _/ -_) '_| '_ \ '_| (_-< -_) | __ / -_) | '_ \/ -_) '_|
  \___|_|\__|_||_\_,_|_.__/ |___|_||_\__\___|_| | .__/_| |_/__|___| |_||_\___|_| .__/\___|_|  
                                                |_|                            |_|            
```

## Description

This is the Dockerfile for building Github Enterprise Helper (ghe-helper).
Github Enterprise Helper is a container platform built with tooling for
interacting with Github Enterprise and Github.com data and functionality.

The container launches multiple  ``` byobu ``` windows which present different 
GHE tooling or vizualizes logging of the GHE instance.

The core of this originated around a project to consolidate multiple SCMs into 
Github Enterprise.  

You can find published versions of this image on the [Docker Hub.](https://hub.docker.com/u/ppouliot)

* [![](https://images.microbadger.com/badges/image/ppouliot/ghe-helper.svg)](https://microbadger.com/images/ppouliot/ghe-helper) [![](https://images.microbadger.com/badges/version/ppouliot/ghe-helper.svg)](https://microbadger.com/images/ppouliot/ghe-helper) ppouliot/ghe-helper
 
## Typical Use Cases

The typical usage of this is GHE Administration however falls into 
the following 3 sub catagories.

1. Github to Github Enterprise Migrations
2. Github/Github Enteprise Backups
3. Creation of markup using tooling specific for use in GH-Pages/GHE-Pages  


## Github to Github Enterprise Migrations

   1. **Required Environment Varibles**

      The following Environmental Variables must be set either in the `docker run ` statement
      by using a file containing the variables and supplying the `--env-file <your_file>`
      or using `-e` and pass in each required variable independently.
      The following variables are needed for successful migrations

      * GHE_HOST: The hostname of your github enterprise server
      * GHE_TOKEN: A token from your Github Enterprise server which has Site Admin Privileges.
      * GHE_SSH_USER: The name of your Github Enterprise server administrator account
      * GHE_SSH_PORT: The administrative ssh port of your Github Enterprise Instancea.
      * GHE_PASS: The password for the Github Enterprise Admin Site.
      * GHE_USER: The username of the account used for GHE_TOKEN
      * GH_TOKEN: The Token of an Owner of the Repository on Github.com
      * GHE_TOTP: same as GHE_TOKEN

      **Example: Environment Variables**

      Included in this project is a sample [ file ](/environment.example) containing the environment
      variables needed to bo be configured in order to successfully migrate
      Organizations from Github to Github Enterprise.  This file can be used as template.

      ```
      GHE_HOST=github.yourghe.com
      GHE_TOKEN= 1234567890abcdef1234567890abcdef12345678
      GHE_SSH_USER=admin
      GHE_SSH_PORT=122
      GHE_USER=you@your-email.com
      GHE_PASS=Y0urGh3P@ss0rd
      GH_TOKEN=1234567890abcdef1234567890abcdef12345678
      GHE_TOTP=1234567890abcdef1234567890abcdef12345678
      ```

   2. **SSH Keys**

      SSH Keys that have admin access to the Github Enterprise Instance are required.  These can be passed
      into the container at runtime using ``` -v path/to/.ssh:/root/.ssh ```. Additional information on how
      to generate ssh keys can be found [here.](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/)
      

   3. **Running the Container**

      The following docker commands can be used to run the container.
   
      ```
      docker pull ppouliot/ghe-helper:latest
      docker run -h ghe-helper -it --env-file .env -v $HOME/.ssh:/root/.ssh  -p 4000:4000 -p 4567:4567 ppouliot/ghe-helper
      ```

      Once properly executed you will be placed into a running instance of the GHE-Helper presented as a multi-window console experience.
      The console is broken into four different areas.   

## GHE/ghe-migrator.log

      This includes the [GHE](https://github.com/ppouliot/ghe) application.  GHE is a python application wrapping GHE tooling on the GHE Appliance.
      GHE can be used for basic admin tasks as well as Github to GHE migrations. 
      General usage information can be obtained by running ``` help ``` from within the ``` GHE> ``` command shell or by visitingi
      the documentation [here.](https://github.com/ppouliot/ghe/wiki)
      
      For Github to Github specific information please follow the documentation located at the [fork](https://github.com/ppouliot/ghe) of the
      [original](https://git.generalassemb.ly/ga-admin-utils/ghe) GHE project that I am currently extending & maintaining [here.](https://github.com/ppouliot/ghe/wiki/ghe-migrate)

## Github Backup Utilities

   1. **Accessing the Github backup utilities**

      Github provides [tooling](https://github.com/github/backup-utils) for performing backups of Github Enterprise.  The Github Backup Utilities are included within this container
      image.  Additoinally a ``gh-backup`` user is also added to the container image and configured for access to installed Github Backup Utilities..
      Currently in order to access the  ``gh-backup`` user existing in this container you must run ``` su - gh-backup ``` as passed in option from the original docker command.

   2. **Example Command**

       ( coming soon. )


## Github Pages

( coming soon. )

## References

The following resources were used in the creation of this platform.

  1. github/backup-utils
     1. https://github.com/github/backup-utils
  2. GHE
     1. https://github.com/ppouliot/ghe (Code used in this container)
     2. https://git.generalassemb.ly/ga-admin-utils/ghe (Origianl Source of the code used in this container)
