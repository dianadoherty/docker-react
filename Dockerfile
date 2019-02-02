# Builder Phase
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install yarn
RUN yarn install
COPY . .
RUN yarn run build 
# /app/build has all the stuff we care about

# Last Phase
FROM nginx:stable-alpine
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
