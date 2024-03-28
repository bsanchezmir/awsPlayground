# base node image
FROM node:18-alpine as base

# Adding bash to be able to access containers for debugging
RUN apk update
RUN apk upgrade
RUN apk add bash
