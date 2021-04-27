#BUILD PHASE
FROM node:alpine as builder

#Set our working directory inside of the container
WORKDIR '/app'

#Copy the package.json from the project into the container's working directory
COPY ./package*.json ./

#Install the dependencies
RUN yarn install

#Copy the files into the container
COPY . .

#Run the build command inside of the container (in the WORKDIR as /app/build)
RUN yarn build

#RUN PHASE
FROM nginx

EXPOSE 80

#Copy the build folder from the builder phase inside the nginx Container
COPY --from=builder /app/build /usr/share/nginx/html


