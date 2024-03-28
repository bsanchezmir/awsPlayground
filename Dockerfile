FROM node:17-alpine as base
USER root
EXPOSE 20-1024
RUN chmod 777 /app
USER admin
CMD ["node", "app.js"]
