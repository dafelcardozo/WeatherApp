FROM node:alpine3.10
COPY . ./weather_app
WORKDIR ./weather_app
RUN npm ci
RUN npm run build
EXPOSE 8080
CMD ["npm",  "run", "serve"]