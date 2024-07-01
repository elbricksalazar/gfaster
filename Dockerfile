FROM node:18.17.0

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
ARG NPM_TOKEN=$NPM_TOKEN
ARG DEPLOY_ENVIRONMENT=$DEPLOY_ENVIRONMENT
ENV ENV_DEPLOY_ENVIRONMENT=$DEPLOY_ENVIRONMENT
RUN echo "TOKEN NPM:"
RUN echo "*****************"
RUN echo "$NPM_TOKEN"
RUN echo "*****************"
RUN echo "DEPLOY_ENVIRONMENT:"
RUN echo "*****************"
RUN echo "$DEPLOY_ENVIRONMENT"
RUN echo "*****************"

RUN npm config set elbricksalazar:registry=https://npm.pkg.github.com/
RUN npm config set //npm.pkg.github.com/:_authToken=$NPM_TOKEN

# RUN npm config set @ncgroup:registry="https://gitlab.com/api/v4/packages/npm/"
# RUN npm config set "//gitlab.com/api/v4/packages/npm/:_authToken"="$NPM_TOKEN"
RUN npm config list
COPY package*.json ./
#COPY .npmrc ./

RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 3000

CMD ["sh", "-c", "npm run start:${ENV_DEPLOY_ENVIRONMENT}"]


