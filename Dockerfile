# get the base node image
FROM node:14.18.2-alpine as builder

# set the working dir for container
WORKDIR /frontend

# copy the json file first
COPY package.json /frontend

# install npm dependencies
RUN npm install
# copy other project files
COPY . .

# build the folder
RUN npm run build

# Handle Nginx
FROM nginx
RUN rm -rf /etc/nginx/conf.d/*
COPY --from=builder /frontend/build /usr/share/nginx/html
COPY ./fe.conf /etc/nginx/conf.d/fe.conf

