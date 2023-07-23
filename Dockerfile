# git commit -a -m "message"
# TAG=$(git rev-parse HEAD)
# docker build -t gmhafiz/web .
# docker run --rm -it -p 8080:80 --name web gmhafiz/web:$TAG
# http://localhost:8080
FROM node:18 as build-stage

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .
RUN npm run build

FROM cgr.dev/chainguard/nginx:1.25.1 as production-stage

COPY --from=build-stage /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
