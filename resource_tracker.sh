#!/bin/bash

# === CONFIGURATION ===
LOG_DIR=~/EC2_Resource_Tracker
SCRIPT_DIR=~/aws-resource-tracker
ALERT_EMAIL="your_mail"
AWS_REGION="us-east-1"

# === ENSURE LOG DIR EXISTS ===
mkdir -p "$LOG_DIR"

# === DETERMINE NEXT LOG NUMBER ===
cd "$LOG_DIR"
LAST_LOG=$(ls resource_tracker_*.log 2>/dev/null | awk -F_ '{print $3}' | sed 's/.log//' | sort -n | tail -1)
LOG_NUM=$((LAST_LOG + 1))
LOG_FILE="$LOG_DIR/resource_tracker_${LOG_NUM}.log"

# === START LOGGING ===
{
  echo "====================================="
  echo "        EC2 RESOURCE TRACKER"
  echo "====================================="
  echo ""
  echo "📅 Date       : $(date)"
  echo "🌐 Hostname   : $(hostname)"
  echo ""

  echo "-------------------------------------"
  echo "🧠 MEMORY USAGE"
  echo "-------------------------------------"
  free -h
  echo ""

  echo "-------------------------------------"
  echo "💾 DISK USAGE"
  echo "-------------------------------------"
  df -h
  echo ""

  echo "-------------------------------------"
  echo "🗂️ DISK INODES"
  echo "-------------------------------------"
  df -i
  echo ""

  echo "-------------------------------------"
  echo "🧮 CPU INFORMATION"
  echo "-------------------------------------"
  lscpu
  echo ""

  echo "-------------------------------------"
  echo "📡 NETWORK INFORMATION"
  echo "-------------------------------------"
  ip addr
  echo ""

  echo "-------------------------------------"
  echo "📋 TOP PROCESSES (CPU)"
  echo "-------------------------------------"
  top -b -n 1 | head -20
  echo ""

  echo "-------------------------------------"
  echo "🧾 LAST 10 dmesg ENTRIES"
  echo "-------------------------------------"
  sudo dmesg | tail -10 || echo "(Permission denied for dmesg)"
  echo ""

  echo "====================================="
  echo "            END OF LOG"
  echo "====================================="

} > "$LOG_FILE"

# === SEND DAILY LOG EMAIL ===
aws ses send-email \
  --region "$AWS_REGION" \
  --from "$ALERT_EMAIL" \
  --destination "ToAddresses=$ALERT_EMAIL" \
  --message "Subject={Data=EC2 Resource Tracker Log #${LOG_NUM},Charset=utf8},Body={Text={Data=Log #${LOG_NUM} has been created and pushed to GitHub on $(date).,Charset=utf8}}"

# === PUSH TO GITHUB ===
cd "$LOG_DIR"
git add "$LOG_FILE"
git commit -m "Add log #${LOG_NUM} - $(date)"
git push origin main

echo "----EC2 Resource Tracker Complete----"

