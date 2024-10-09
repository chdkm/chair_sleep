# ベースイメージの指定
FROM ruby:3.2.2

# 環境変数
ENV TZ Asia/Tokyo
ENV LANG ja_JP.UTF-8
ENV LC_ALL C.UTF-8
ENV EDITOR=vim

# dbにpostgreSQLを使用するので対象のパッケージをインストール
RUN apt-get update && apt-get install -y \
    postgresql-client \
    vim \
    curl \
    wget \
    unzip \
    xvfb \
    default-jdk \
    chromium-driver

# ChromeとSeleniumをインストール
RUN wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i google-chrome-stable_current_amd64.deb || apt-get -f install -y \
    && rm google-chrome-stable_current_amd64.deb

# Seleniumサーバーをインストール
RUN wget -q https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar \
    -O /usr/local/bin/selenium-server-standalone.jar

# seleniumサーバー起動スクリプト
RUN echo "#!/bin/bash\n\
xvfb-run java -jar /usr/local/bin/selenium-server-standalone.jar" > /usr/local/bin/selenium-server \
    && chmod +x /usr/local/bin/selenium-server

# appディレクトリを作成
RUN mkdir /app

# コマンドを実行するディレクトリを/appに指定
WORKDIR /app

# ローカルのGemfileとGemfile.lockをコンテナ内にコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# bundle installを実行
RUN bundle install

# Install yarn
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash - \
  && wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y nodejs yarn \
  && apt-get install -y cron

# ローカルの現在のディレクトリをコンテナ内にコピー
COPY . /chair_sleep

# entrypoint.shを実行するための記述
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Seleniumサーバーをバックグラウンドで起動するための追加設定
CMD ["bash", "-c", "selenium-server & rails server -b '0.0.0.0'"]

# コンテナがリッスンするPORTを指定
EXPOSE 3000
