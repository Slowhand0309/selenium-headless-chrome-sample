ARG RUBY_VERSION=2.6

FROM ruby:${RUBY_VERSION}

ARG INSTALL_PATH=/usr/src/app

# Install essentials
RUN apt-get update -qq && apt-get install -y --no-install-recommends build-essential \
 && rm -rf /var/lib/apt/lists/*

# Install dependencies & Chrome
ARG CHROME_VERSION
SHELL ["/bin/bash", "-eo", "pipefail", "-c"]
RUN apt-get update && apt-get -y --no-install-recommends install zlib1g-dev liblzma-dev wget xvfb unzip libgconf-2-4 libnss3 nodejs \
 && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -  \
 && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
 && apt-get update && apt-get -y --no-install-recommends install google-chrome-stable=$CHROME_VERSION fonts-ipafont fonts-ipaexfont \
 && rm -rf /var/lib/apt/lists/*

# Install Chrome driver
ARG CHROMIUM_DRIVER_VERSION
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/$CHROMIUM_DRIVER_VERSION/chromedriver_linux64.zip \
    && unzip /tmp/chromedriver.zip chromedriver -d /usr/bin/ \
    && rm /tmp/chromedriver.zip \
    && chmod ugo+rx /usr/bin/chromedriver

WORKDIR $INSTALL_PATH
ADD Gemfile $INSTALL_PATH
ADD Gemfile.lock $INSTALL_PATH
RUN bundle install --system

ADD . $INSTALL_PATH
ENV LANG=ja_JP.UTF-8
CMD bin/execute.sh