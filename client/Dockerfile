#
# BudgetTracker Dockerfile for UI
#
FROM ubuntu:bionic
USER root

RUN apt-get update
RUN apt-get install -y curl nginx nodejs build-essential

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update
RUN apt-get install -y yarn


# Remove the default Nginx configuration file
RUN rm -v /etc/nginx/nginx.conf

# Copy a configuration file from the current directory
ADD nginx.conf /etc/nginx/
ADD / /usr/share/nginx/
RUN yarn --version
RUN cd /usr/share/nginx && yarn install

# node_modules is not in the web root because the idea is that dependencies are read-only during development.
# The symlink making in this Dockerfile may be redundant it the symlink remains in the repo.
# It exists in the repo for when you use "make rundev" that mounts your local "web" folder.
RUN ln -s /usr/share/nginx/node_modules /usr/share/nginx/web/node_modules

#ADD node_modules /usr/share/nginx/html/node_modules

# Append "daemon off;" to the beginning of the configuration
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Expose ports
EXPOSE 90

# Set the default command to execute
# when creating a new container
CMD service nginx start

