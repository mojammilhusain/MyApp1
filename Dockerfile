#Stage 1
FROM node:16.2.0 AS build
WORKDIR /MYAPP
COPY package*.json  ./
RUN npm install
COPY . .
RUN npm run build --prod


#Stage 2
FROM nginx:1.21.1
COPY --from=build /MYAPP/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD [ "nginx", "-g", "daemon off" ]