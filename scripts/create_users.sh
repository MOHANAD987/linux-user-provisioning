#!/bin/bash
set -e

CSV_FILE="../data/employee.csv"
OUTPUT_FILE="../output/users_credentials.txt"
LOG_FILE="../logs/user_creation.log"

mkdir -p ../output ../logs

if [ "$EUID" -ne 0 ]; then
  echo "❌ Run this script as root"
  exit 1
fi

if [ ! -f "$CSV_FILE" ]; then
  echo "❌ CSV file not found"
  exit 1
fi

echo "username,password" > "$OUTPUT_FILE"
echo "User Creation Log - $(date)" > "$LOG_FILE"

while IFS=, read -r USERNAME FULLNAME; do

  [[ "$USERNAME" == "username" ]] && continue

  if id "$USERNAME" &>/dev/null; then
    echo "⚠ $USERNAME already exists - skipped" | tee -a "$LOG_FILE"
    continue
  fi

  PASSWORD=$(openssl rand -base64 12)

  useradd -m -s /bin/bash -c "$FULLNAME" "$USERNAME"
  echo "$USERNAME:$PASSWORD" | chpasswd
  chage -d 0 "$USERNAME"

  echo "$USERNAME,$PASSWORD" >> "$OUTPUT_FILE"
  echo "✔ User created: $USERNAME" | tee -a "$LOG_FILE"

done < "$CSV_FILE"

echo "🎉 All users processed successfully"

