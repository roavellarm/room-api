FROM ruby:2.5.5
ENV EDITOR="/bin/true"
# Install container dependencies
RUN apt-get update && apt-get install -y git libc-ares2 libv8-3.14.5 postgresql-client --no-install-recommends && rm -rf /var/lib/apt/lists/
# Install NodeJS Version 12 to use MJML templates
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs && npm install -g mjml@4.3.0
ENV PATH $PATH:/node_modules/mjml/lib
# Set the work directory inside container
RUN mkdir /app
WORKDIR /app
# Copy the Gemfile inside the container
COPY Gemfile /app/
# Install dependencies
RUN gem install bundler -v '2.0.2'
# Copy all the rest inside work directory
COPY . /app
# Access /app and install gems
RUN cd app/
RUN bin/bundle install --jobs 32 --retry 4
