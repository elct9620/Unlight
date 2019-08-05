FROM ubuntu:xenial

# Install Dependencies
RUN apt-get update \
    && apt-get install -y  --no-install-recommends \
            git \
            default-jdk \
            ruby \
            ruby-dev \
            mysql-client \
            libmysqlclient-dev \
            ant \
            unzip \
            curl \
            build-essential \
            sqlite3 \
            libsqlite3-dev \
            memcached \
    && apt-get purge -y --auto-remove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
              /tmp/*

RUN gem install bundler

# Setup Application
RUN mkdir -p /app/server \
            /app/client \
            /app/dist
WORKDIR /app

# Setup Server
ADD app/server/Gemfile /app/server
RUN cd /app/server && bundle install

# Setup Flex
ENV FLEXSDK_VERSION 3.6a
RUN curl -fL -o /tmp/flexsdk.zip http://download.macromedia.com/pub/flex/sdk/flex_sdk_${FLEXSDK_VERSION}.zip \
    && unzip /tmp/flexsdk.zip -d /usr/lib/flex3 \
    && rm -rf /tmp/*

# Add Source Files
ADD app/ /app
ADD assets/ /app/client
# Add fonts
ADD fonts/wt004.ttf /app/client/data
ADD fonts/cwming.ttf /app/client/data

ADD patches/ /app/patches
ADD build /app

# Prepare necessary directory
RUN mkdir -p /app/server/bin/pids \
    && mkdir -p /app/client/script/data \
    && mkdir -p /app/server/data/backup

# Apply patch
RUN cp /app/server/src/db_config.rb_orig /app/server/src/db_config.rb \
    && cp /app/server/src/server_ip.rb_orig /app/server/src/server_ip.rb \
    && cp /app/server/src/constants/locale_constants.rb_sb /app/server/src/constants/locale_constants.rb \
    # Missing
    && cp /app/server/src/constants/locale_constants.rb_sb /app/server/src/constants/locale_constants.rb_tcn \
    && cp /app/client/src/Unlight-config.orig /app/client/src/Unlight-config.xml

RUN patch -p0 < patches/db_config.rb.patch \
    && patch -p0 < patches/import_csv_data.rb.patch \
    && patch -p0 < patches/unlight.rb.patch \
    && patch -p0 < patches/create_const_data.rb.patch \
    && patch -p0 < patches/Unlight-config.xml.patch \
    && patch -p0 < patches/create_font_swf.rb.patch
