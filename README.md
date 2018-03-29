# Docker PHP-based image for Moodle applications

## Description

Docker PHP-based image for Moodle applications.
Based on [docker-ubuntu-apache-php](https://github.com/demmonico/docker-ubuntu-apache-php) image (v3.0). 
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
- DMC_APP_MOODLE_REPOSITORY
- DMC_APP_MOODLE_TAG_VERSION (use this or DMC_APP_MOODLE_BRANCH)
- DMC_APP_MOODLE_BRANCH  (use this or DMC_APP_MOODLE_TAG_VERSION)


## Usage

Docker Compose:

```sh
...
app:
  build: local_path_to_dockerfile
    
  volumes:
    # moodle data
    - ./app/data:/var/moodledata
    
  environment:
    # name of internal DB host
    - DMC_DB_SERVICE=db
    
    # moodle repo data
    - DMC_APP_MOODLE_REPOSITORY=https://github.com/iomad/iomad.git
    - DMC_APP_MOODLE_TAG_VERSION=""
    - DMC_APP_MOODLE_BRANCH=IOMAD_33_STABLE
```


## Change log

See the [CHANGELOG](CHANGELOG.md) file for change logs.
