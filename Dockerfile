FROM node:14-slim
COPY . .
RUN npm install
RUN npm build
RUN CI=true
EXPOSE 8081
CMD [ "npm", "start" ]