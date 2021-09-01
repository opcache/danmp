#!/bin/sh

if [ -d /etc/nginx/conf.d ]; then
  echo "[i] Nginx directory already present, skipping creation"
else
  echo "[i] Nginx directory not found, creating Nginx"
  mkdir -p /etc/nginx/conf.d/
fi

if [ -d /data/wwwroot/www.xxxxxx.cn ]; then
  echo "[i] Nginx directory already present, skipping creation"
else
  echo "[i] Nginx directory not found, creating Nginx"
  mkdir -p /data/wwwroot/www.xxxxxx.cn
  /bin/cp /opt/config/info.php /data/wwwroot/www.xxxxxx.cn/
fi

if [ -d /data/nginx-log/waflogs ]; then
  echo "[i] Nginx directory already present, skipping creation"
else
  echo "[i] Nginx directory not found, creating Nginx"
  mkdir -p /data/nginx-log/waflogs/
fi

  if [ -f "/etc/nginx/conf.d/waf/wafinit.lua" ]; then
  echo "[i] Nginx file already present, skipping creation"
  else
  echo "[i] Nginx file not found, creating Nginx file"
    /bin/cp -R /opt/config/waf /etc/nginx/conf.d/
    /bin/cp /opt/config/nginx-waf.conf /etc/nginx/nginx.conf
  fi

  if [ -f "/etc/nginx/conf.d/rewrite/wordpress.conf" ]; then
  echo "[i] Nginx file already present, skipping creation"
  else
  echo "[i] Nginx file not found, creating Nginx file"
    /bin/cp -R /opt/config/rewrite /etc/nginx/conf.d/
  fi
  if [ -f "/etc/nginx/conf.d/www.xxxxxx.cn.conf" ]; then
  echo "[i] Nginx file already present, skipping creation"
  else
  echo "[i] Nginx file not found, creating Nginx file"
    /bin/cp /opt/config/www.xxxxxx.cn.conf /etc/nginx/conf.d/
  fi
  if [ -f "/data/nginx-log/waflogs/waf.log" ]; then
  echo "[i] Nginx file already present, skipping creation"
  else
  echo "[i] Nginx file not found, creating Nginx file"
    touch /data/nginx-log/waflogs/waf.log
    chmod  777 /data/nginx-log/waflogs/waf.log
  fi


/usr/sbin/nginx -g "daemon off;"
echo "ok"
