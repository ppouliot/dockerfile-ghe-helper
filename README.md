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

## Github to Github Enterprise Mitrations
### Required Environment Varibles
The following Environmental Variables must be set either in the `docker run ` statement
by using a file containing the variables and supplying the `--env-file <your_file>`
or using `-e` and pass in each required variable independently.

####  example: Environment Variables

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

Included in this project is a sample [ file ](/environment.example) containing the environment
variables needed to bo be configured in order to successfully migrate
Organizations from Github to Github Enterprise. 

## References

The following resources were used in the creation of this platform.

1. github/backup-utils
  1. https://github.com/github/backup-utils
2. GHE
  1. https://github.com/ppouliot/ghe (Code used in this container)
  2. https://git.generalassemb.ly/ga-admin-utils/ghe (Origianl Source of the code used in this container)
