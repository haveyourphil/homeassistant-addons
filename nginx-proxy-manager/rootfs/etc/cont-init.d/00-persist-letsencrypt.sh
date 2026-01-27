#!/command/with-contenv sh
set -eu

mkdir -p /data/letsencrypt

# If /etc/letsencrypt is a normal dir, migrate contents (best effort) then replace with symlink
if [ -d /etc/letsencrypt ] && [ ! -L /etc/letsencrypt ]; then
  # Copy existing certs into /data/letsencrypt if /data is empty
  if [ -z "$(ls -A /data/letsencrypt 2>/dev/null || true)" ] && [ -n "$(ls -A /etc/letsencrypt 2>/dev/null || true)" ]; then
    cp -a /etc/letsencrypt/. /data/letsencrypt/ || true
  fi

  rm -rf /etc/letsencrypt
fi

# Ensure symlink exists
ln -sfn /data/letsencrypt /etc/letsencrypt
