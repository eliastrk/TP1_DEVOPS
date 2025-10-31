FROM node:trixie-slim

RUN useradd invite

USER invite

COPY broken-app /home/invite/Docker

USER root
RUN chown -R invite:invite /home/invite
USER invite

WORKDIR /home/invite/Docker

RUN npm install

EXPOSE 3000

ENTRYPOINT ["node", "server.js"]
