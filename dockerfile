FROM node:20.14.0 As build 
WORKDIR /app 
COPY package*.json ./
RUN npm install 
RUN node -v
RUN npm -v
COPY . .
RUN npm list
RUN npm run build -- --configuration production

FROM nginx:alpine
COPY --from=build /app/dist/ladaliapp/browser /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


