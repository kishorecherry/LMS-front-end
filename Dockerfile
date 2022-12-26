FROM node:14-alpine AS build
RUN mkdir /app_build
WORKDIR /app_build
COPY . /app_build
RUN npm install -g @angular/cli
RUN npm install -f
RUN ng build --prod
FROM amazon/aws-cli
RUN mkdir /front_app
WORKDIR /front_app
COPY --from=build /app_build/public /front_app
RUN aws s3 cp /front_app s3://kishore2345 --recursive
EXPOSE 3000
