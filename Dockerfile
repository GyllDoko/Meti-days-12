# Build location for Node.js download (disposable)
FROM ruby:3.0.1 AS nodejs
WORKDIR /tmp
# Download Node.js
RUN curl -LO https://nodejs.org/dist/v12.14.1/node-v12.14.1-linux-x64.tar.xz
RUN tar xvf node-v12.14.1-linux-x64.tar.xz
RUN mv node-v12.14.1-linux-x64 node

# Build locations for Rails apps
FROM ruby:3.0.1
# Copy a set of files from the build location for Node.js download and make them available
COPY --from=nodejs /tmp/node /opt/node
ENV PATH /opt/node/bin:$PATH
# Install yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH /root/.yarn/bin:/root/.config/yarn/global/node_modules/.bin:$PATH
WORKDIR /app
RUN bundle config set path vendor/bundle
# Command to be executed if no command is specified when docker run is executed.
CMD ["bash"]
