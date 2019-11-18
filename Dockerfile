FROM node:10.15.3 as source
WORKDIR /src/technology-radar
COPY package.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx:1.15.9
WORKDIR /opt/technology-radar
COPY --from=source /src/technology-radar/dist .
COPY default.template /etc/nginx/conf.d/default.conf
CMD ["nginx", "-g", "daemon off;"]
