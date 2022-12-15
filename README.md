# Captionista: A MySQL + Flask Boilerplate Project

This repo contains a boilerplate setup for spinning up 2 docker containers: 
1. A MySQL 8 container for obvious reasons
1. A Python Flask container that implements a rest API

## Purpose
Captionista is intended to be a platform where users can upload captions for certain tags, or upload photos and have captions suggested.

## Code Demo
https://github.com/nolanpollack/captionista/blob/9d0552e95e648c1608a581aa62c1b4b2bf36c1ab/overview.mp4

### AppSmith Demo
https://github.com/nolanpollack/captionista/blob/74ac2491e6de1bc4d3f6044d4f035e562ce729cc/appsmith%20demo.mkv

## How to setup and start the containers

1. Clone this repository.  
1. In a terminal or command prompt, navigate to the folder with the `docker-compose.yml` file.  
1. Build the images with `docker compose build`
1. Start the containers with `docker compose up`.  To run in detached mode, run `docker compose up -d`. 
