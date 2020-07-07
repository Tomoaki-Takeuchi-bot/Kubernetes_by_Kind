FROM alpine:3.9

COPY docker-entrypoint.sh /usr/local/bin

# ユーザー追加、実行可能権限、Mongodb使用ディレクトリ追加
RUN \
  adduser -g mongodb -DH -u 1000 mongodb; \
  apk --no-cache add mongodb=4.0.5-r0; \
  chmod +x /usr/local/bin/docker-entrypoint.sh; \
  mkdir -p /data/db; \
  chown -R mongodb:mongodb /data/db;

# volume,exposeでDockerイメージを使用していることを宣言
VOLUME /data/db

EXPOSE 27017

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD [ "mongod" ]