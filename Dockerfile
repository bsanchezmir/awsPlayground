FROM node:17-alpine as base
USER root
RUN curl -O http://example.com/somefile.zip
COPY . .
EXPOSE 20-1024
RUN chmod 777 /app
USER admin
CMD ["node", "app.js"]
