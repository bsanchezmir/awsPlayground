FROM node:10.0.0
USER root
RUN apt-get update && apt-get install -y curl
RUN curl -O http://example.com/somefile.zip
COPY . .
EXPOSE 20-1024
RUN chmod 777 /app
USER admin
CMD ["node", "app.js"]