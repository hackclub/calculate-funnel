FROM ruby:2.1

# Have up to date repositories
RUN apt-get update -y

# Install Heroku client
RUN apt-get install software-properties-common apt-transport-https -y
RUN add-apt-repository "deb https://cli-assets.heroku.com/branches/stable/apt ./"
RUN curl -L https://cli-assets.heroku.com/apt/release.key | apt-key add -
RUN apt-get update -y
RUN apt-get install heroku -y

# Install expect for scripting Heroku's CLI
RUn apt-get install expect -y

# Set up environment
WORKDIR /usr/src/app
COPY Gemfile* .
RUN bundle install
ADD . /usr/src/app
