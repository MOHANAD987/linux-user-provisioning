#!/bin/bash
set -e

CSV_FILE="../data/employee.csv"

mkdir -p ../data

read -p "Enter username: " USERNAME
read -p "Enter full name: " FULLNAME

if [[ -z "$USERNAME" || -z "$FULLNAME" ]]; then
  echo "❌ Username or Full Name cannot be empty"
  exit 1
fi

if [ ! -f "$CSV_FILE" ]; then
  echo "username,full_name" > "$CSV_FILE"
fi

if grep -q "^$USERNAME," "$CSV_FILE"; then
  echo "⚠ User already exists in CSV"
  exit 1
fi

echo
echo "User Information:"
echo "Username : $USERNAME"
echo "Full Name: $FULLNAME"
read -p "Confirm [y/n]: " CONFIRM

if [[ "$CONFIRM" =~ ^[Yy]$ ]]; then
  echo "$USERNAME,$FULLNAME" >> "$CSV_FILE"
  echo "✔ User data saved successfully"
else
  echo "❌ Operation canceled"
fi

