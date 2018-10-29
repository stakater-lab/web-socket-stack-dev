# web-socket-stack-dev

Repository to contain a sample web socket application with mongodb, hazelcast and rabbitmq.

## Pre-reqs

First install helm (locally) & tiller on the server. Use following guide to setup:

- https://github.com/stakater/til/blob/master/helm/using-helm-in-production.md

## Deployment

Run `make install CHART_NAME=web-socket-stack`

## Delete

Run `make delete CHART_NAME=web-socket-stack`