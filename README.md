[![CircleCI Build Status](https://img.shields.io/circleci/project/cptactionhank/docker-atlassian-confluence/master.svg?label=CircleCI)](https://circleci.com/gh/cptactionhank/docker-atlassian-confluence) [![Open Issues](https://img.shields.io/github/issues/cptactionhank/docker-atlassian-confluence.svg)](https://github.com/cptactionhank/docker-atlassian-confluence/issues) [![Stars on GitHub](https://img.shields.io/github/stars/cptactionhank/docker-atlassian-confluence.svg)](https://github.com/cptactionhank/docker-atlassian-confluence/stargazers) [![Forks on GitHub](https://img.shields.io/github/forks/cptactionhank/docker-atlassian-confluence.svg)](https://github.com/cptactionhank/docker-atlassian-confluence/network) [![Stars on Docker Hub](https://img.shields.io/docker/stars/cptactionhank/atlassian-confluence.svg)](https://hub.docker.com/r/cptactionhank/atlassian-confluence/) [![Pulls on Docker Hub](https://img.shields.io/docker/pulls/cptactionhank/atlassian-confluence.svg)](https://hub.docker.com/r/cptactionhank/atlassian-confluence/) [![Sponsor by PayPal](https://img.shields.io/badge/sponsor-PayPal-blue.svg)](https://paypal.me/cptactionhank/5)

# Atlassian Confluence in a Docker container

This is a containerized installation of Atlassian Confluence with Docker, and it's a match made in heaven for us all to enjoy. The aim of this image is to keep the installation as straight forward as possible, but with a few Docker related twists. You can get started by clicking the appropriate link below and reading the documentation.

* [Atlassian JIRA Core](https://cptactionhank.github.io/docker-atlassian-jira)
* [Atlassian JIRA Software](https://cptactionhank.github.io/docker-atlassian-jira-software)
* [Atlassian JIRA Service Desk](https://cptactionhank.github.io/docker-atlassian-service-desk)
* [Atlassian Confluence](https://cptactionhank.github.io/docker-atlassian-confluence)
* [Atlassian Bitbucket](https://cptactionhank.github.io/docker-atlassian-bitbucket)
* [Atlassian Bamboo](https://cptactionhank.github.io/docker-atlassian-bamboo)

If you want to help out, you can check out the contribution section further down.

## I'm in the fast lane! Get me started

To quickly get started running a Confluence instance, use the following command:
```bash
docker run --detach --publish 8090:8090 cptactionhank/atlassian-confluence:latest
```

Then simply navigate your preferred browser to `http://[dockerhost]:8090` and finish the configuration.

## Configuration

You can configure a small set of things by supplying the following environment variables

| Environment Variable   | Description |
| ---------------------- | ----------- |
| X_PROXY_NAME           | Sets the Tomcat Connectors `ProxyName` attribute |
| X_PROXY_PORT           | Sets the Tomcat Connectors `ProxyPort` attribute |
| X_PROXY_SCHEME         | If set to `https` the Tomcat Connectors `secure=true` and `redirectPort` equal to `X_PROXY_PORT`   |
| X_PATH                 | Sets the Tomcat connectors `path` attribute |
| X_CROWD_SSO            | Set to `true` to enable SSO via Atlassian Crowd

## How to enable SSO via Crowd

Setting X_CROWD_SSO to `true` will do two things:

- enable the *ConfluenceCrowdSSOAuthenticator*
- tell Confluence to load `crowd-properties.conf` from `/var/atlassian/confluence` **(It is your responsibility to put it there!)**

**Warning:** You have to setup the Crowd user directory in Confluence beforehand. After enabling the *ConfluenceCrowdSSOAuthenticator*, you are not able to log in using local accounts anymore.

See the [official Documentation](https://confluence.atlassian.com/crowd/integrating-crowd-with-atlassian-confluence-198573.html) for more information.

This image is based on https://github.com/cptactionhank/docker-atlassian-confluence
