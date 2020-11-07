# https://hub.docker.com/_/node?tab=tags
# Node.js ^12
FROM node:12-alpine3.12
MAINTAINER laszlo.kajan@roche.com
RUN apk update
RUN apk add --no-cache ca-certificates curl git jq
# https://github.com/puppeteer/puppeteer/blob/main/docs/troubleshooting.md#running-on-alpine
# 86.0.4240.111-r0 is available in this node image: lock, to be able to match puppeteer
RUN apk add --no-cache chromium=86.0.4240.111-r0
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser
RUN rm -rf /var/cache/apk/*

RUN curl -o /usr/local/share/ca-certificates/Roche_Root_CA_1_-_G2.crt http://certinfo.roche.com/rootcerts/Roche%20Root%20CA%201%20-%20G2.crt
RUN curl -o /usr/local/share/ca-certificates/Roche_G3_Root_CA.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Root%20CA.crt
RUN curl -o /usr/local/share/ca-certificates/Roche_G3_Issuing_CA_1.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Issuing%20CA%201.crt
RUN curl -o /usr/local/share/ca-certificates/Roche_G3_Issuing_CA_2.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Issuing%20CA%202.crt
RUN curl -o /usr/local/share/ca-certificates/Roche_G3_Issuing_CA_3.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Issuing%20CA%203.crt
RUN curl -o /usr/local/share/ca-certificates/Roche_G3_Issuing_CA_4.crt http://certinfo.roche.com/rootcerts/Roche%20G3%20Issuing%20CA%204.crt
RUN update-ca-certificates

# Match to dependencies of
#	https://code.roche.com/sap-aspire/scp/supporting-projects/devops-fb-assign-transport-request/-/blob/master/package.json
RUN npm install "axios@0.21.0" "command-line-args@5.1.1" "command-line-usage@6.1.0" "puppeteer@chrome-86" "sprintf-js@1.1.2"
#RUN npm install "@sap-aspire/assign-transport-request"
