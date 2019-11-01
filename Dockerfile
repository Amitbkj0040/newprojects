# base image
FROM node:10.8.0 as builder
# set working directory
RUN mkdir /usr/src/app
WORKDIR /usr/src/app

# add `/usr/src/app/node_modules/.bin` to $PATH
ENV PATH /usr/src/app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /usr/src/app/package.json
RUN npm install
RUN npm install -g @angular/cli@6.1.5 --unsafe

# add app
COPY . /usr/src/app
RUN ng build --prod

FROM bi201301/nginx-static-gm:latest
COPY --from=builder /usr/src/app/dist /var/www/web
