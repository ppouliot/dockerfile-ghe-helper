# dockerfile-ghe-helper

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

## Typical Use Cases

The typical usage of this falls into the following 3 catagories.

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
      docker run --name ghe-helper -it --env-file .env -v ./.ssh:/root/.ssh ppouliot/ghe-helper
      ```

      Once properly executed you will be placed into a running instance of the [GHE](https://github.com/ppouliot/ghe) application.
      General usage information can be obtained by running help from the command shell or by visiting the wiki [here.](https://github.com/ppouliot/ghe/wiki)
      
      For Github to Github specific information please follow the documentation located at the fork of the
      GHE project that I maintain [here.](https://github.com/ppouliot/ghe/wiki/ghe-migrate)

## References

The following resources were used in the creation of this platform.

  1. github/backup-utils
     1. https://github.com/github/backup-utils
  2. GHE
     1. https://github.com/ppouliot/ghe (Code used in this container)
     2. https://git.generalassemb.ly/ga-admin-utils/ghe (Origianl Source of the code used in this container)
