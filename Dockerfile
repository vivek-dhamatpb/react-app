FROM vivekpeerbits/node:18-alpine AS build
# FROM 742834886101.dkr.ecr.us-east-1.amazonaws.com/node:latest as build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

FROM vivekpeerbits/nginx:stable-alpine
# FROM 742834886101.dkr.ecr.us-east-1.amazonaws.com/nginx:latest

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]