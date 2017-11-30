# Docker PHP-based image for Moodle applications

## Description

Docker PHP-based image for Moodle applications.
Based on [docker-ubuntu-apache-php](https://github.com/demmonico/docker-ubuntu-apache-php) image (v2.0). 
Was developed for using with [Docker Manager](https://github.com/demmonico/docker-manager/). 
But could be used separately. 
You could pull image from here and build locally.


### Installs

- see [docker-ubuntu-apache-php](https://github.com/demmonico/docker-ubuntu-apache-php)
- autoinstaller Moodle (starts only if file `app/src/config-dist.php` doesn't exists)


### Build arguments

- see [docker-ubuntu-apache-php](https://github.com/demmonico/docker-ubuntu-apache-php)


### Environment variables

- see [docker-ubuntu-apache-php](https://github.com/demmonico/docker-ubuntu-apache-php)
- MOODLE_REPOSITORY
- MOODLE_TAG_VERSION (use this or MOODLE_BRANCH)
- MOODLE_BRANCH  (use this or MOODLE_TAG_VERSION)


## Usage

Docker Compose:

```sh
...
build: local_path_to_dockerfile
  
volumes:
  # optional ssh keys for git
  - ./ssh-keys:/root/.ssh:ro
  
  # webapp code
  - ./app/src:/var/www/html
  
  # moodle data
  - ./app/data:/var/moodledata
  
env_file:
  # provides values for ENV variables VIRTUAL_HOST, PROJECT, HOST_USER_NAME, HOST_USER_ID
  - host.env
  
environment:
  # name of internal DB host
  - DB_HOST=db
  
  # moodle repo data
  - MOODLE_REPOSITORY=https://github.com/iomad/iomad.git
  - MOODLE_TAG_VERSION=""
  - MOODLE_BRANCH=IOMAD_33_STABLE
```


## Change log

See the [CHANGELOG](CHANGELOG.md) file for change logs.
