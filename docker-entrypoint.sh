#! /bin/sh
INIT_FLAG_FILE=/data/db/init-completed
INIT_LOG_FILE=/data/db/init-mongod.log

# 2:関数実装
start_mongod_as_daemon() {
  echo
  echo "> start mongod ..."
  echo
  mongod \
    --fork \
    --logpath ${INIT_LOG_FILE} \
    --quiet \
    --bind_ip 127.0.0.1 \ #ローカルホスト受付
  --smallfiles
}

create_user() {
  echo
  echo "> create user ..."
  echo
  if [ ! "$MONGO_INITDB_ROOT_USERNAME" ] || [ ! "$MONGO_INITDB_ROOT_PASSWORD" ]; then
    return
  fi
  mongo "${MONGO_INITDB_DATABASE}" <<-EOS
  db.createUser({
    user: "${MONGO_INITDB_ROOT_USERNAME}",
    pwd: "${MONGO_INITDB_ROOT_PASSWORD}",
    roles: [{ role: "root", db: "${MONGO_INITDB_DATABASE:-admin}"}]
  })
EOS
}

# EOF-INITFLAGFILEに出力
create_initialize_flag() {
  echo
  echo "> create initialize flag file ..."
  echo
  cat <<-EOF >"${INIT_FLAG_FILE}"
[$(date +%Y-%m-%dT%H:%M:%S.%3N)] Initialize scripts if finigshed.
EOF
}

stop_mongod() {
  echo
  echo "> stop mongod ..."
  echo
  mongod --shutdown
}

# 1:Mongodb 初期化処理
if [ ! -e ${INIT_LOG_FILE} ]; then
  echo
  echo "--- Initialize MongoDB ---"
  echo
  start_mongod_as_daemon
  create_user
  create_initialize_flag
  stop_mongod
fi

# コマンドを引数に実行
exec "$@"
