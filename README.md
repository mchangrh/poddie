# Poddie

Poddie is a self-hosted media downloader and podcast feed generator. 

Poddie uses [yt-dlp](https://github.com/yt-dlp/yt-dlp) to download the media files into a folder on the local machine (e.g. media server). It then invokes [podcats](https://github.com/jakubroztocil/podcats) to generate a podcast feed for the media files and serves it via the NGINX web server. You can then subscribe to the podcast by adding the podcast feed in a podcast player of your choice.

At the heart of Poddie are:

- A bash script to check for new media, download them, generate a feed for the show, a webpage for the show and an index page.
- A bash script to automatically invoke the bash script above on system startup and periodically.
- A YAML configuration file containing details of the shows to download and index.

## Features

- Downloads media files from third-party websites supported by yt-dlp.
- Supports multiple shows.
- Generates a separate podcast feed (XML) and webpage (HTML) for each show.
- Generates an index page (HTML) of all shows.
- Checks for new episodes automatically at a configurable time interval.
- Simple configuration using a YAML file.
- Automatic yt-dlp updates to overcome frequent third-party website/API changes.

## Installation

Docker installation is supported. Ensure you have [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/) installed on the host machine. 

The latest Docker image for Poddie is available from [Docker Hub](https://hub.docker.com/r/austozi/poddie) but for selected hardware architectures only. You may also build the image yourself, but only for amd64 and arm64, because the upstream linuxserver/nginx image only supports these architectures. 

### Build the Docker image

You may skip this step if using the ready-made image from Docker Hub.

1. Download the source for the [latest release](https://github.com/austozi/poddie/releases/latest) and extract the contents.
2. On the command line, navigate to the extracted directory where Dockerfile is, and execute the following: `docker build -t austozi/poddie:latest .`

### Install the Docker container

1. Download the source for the [latest release](https://github.com/austozi/poddie/releases/latest) and extract the contents.
2. On the command line, navigate to the extracted directory where docker-compose.yml is.
3. Edit docker-compose.yml as appropriate.
4. Configure shows in ./config/poddie/config.yml (mapped to /config/poddie/config.yml in the container).
5. Execute the following: `docker-compose up -d`

## Configuration

### Environment variables

The Poddie container is configured using the following environment variables in docker-compose.yml. Some of these variables will appear in the index page at the root of the web server.

| Environment variable | Function |
|-|-|
| PUID | UserID in the container |
| PGID | GroupID in the container |
| TZ | Timezone in the container |
| PODDIE_BASE_URL | Server URL to access Poddie |
| PODDIE_TITLE | Website title for the Poddie instance |
| PODDIE_ICON | Website icon for the Poddie instance |
| PODDIE_DESCRIPTION | Summary of the Poddie instance |
| PODDIE_UPDATE_INTERVAL | Interval at which to update the podcast feeds and index |

### YAML file

The shows are configured using a YAML file. Save this as config.yml and map it to /config/poddie/config.yml in the container. This configuration must be done before starting the container for the first time, or Poddie will complain.

For example:

```
# config.yml
shows:
  - title: The Title of the Show
    url: https://example.com/podcast # URL fed to yt-dlp, usually a playlist
    icon: https://example.com/podcast/cover.png # Cover art for the show
    description: A summary of what the show is about.
    
  - title: Another show
    url: https://example.com/another-show
    icon: https://example.com/another-show/cover.png
    description: Another summary for another show.
```

## Disclaimer

Use this application at your own risk. 

I am no professional developer. This is a hacky solution that I put together to satisfy a personal need of mine, because I could not get [Podify](https://github.com/podify-org/podify) to work on my machine. This implementation has many limitations. However, I may not have the skills or time to resolve them. However, pull requests are welcome.
