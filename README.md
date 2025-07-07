# 🖥️ EC2 Resource Tracker

A simple yet powerful bash-based monitoring tool that logs system diagnostics (memory, disk, CPU, network, processes, etc.) from an AWS EC2 instance.
Each time you run the script manually, it:
- Saves the output to a timestamped log file
- Commits and pushes the log file to a GitHub repository (https://github.com/Harinineon/EC2_Resource_Tracker.git)
- Sends an email alert confirming log creation

## 📌 Features

- Logs system health stats in a human-readable format
- Automatically names logs as "resource_tracker_<n>.log" based on the file count
- Sends an email notification upon each execution
- Pushes logs to a remote GitHub repository

## 📂 Sample Output Structure

resource_tracker_1.log
resource_tracker_2.log
...(In the github repo)

Each log contains:

- Memory usage (free -h)
- Disk space (df -h)
- Inode usage (df -i)
- CPU architecture and stats (lscpu)
- Network interface info (ip addr)
- Top processes snapshot (top)
- Last 10 kernel log entries (dmesg)
- Timestamps and host info

## 🛠️ Prerequisites

Ensure your EC2 instance has:

- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) installed and configured (aws configure)
- Git installed
- AWS SES verified (sender and receiver emails)
- Internet access to push logs to GitHub and send emails

## ⚙️ Setup Instructions

### 1. GitHub Repository Setup

bash:
git init
git remote add origin https://github.com/<your-username>/<your-repo>.git

### 2. Upload and Make Script Executable

Save the bash script as "resource_tracker.sh" and make it executable:

bash
chmod +x resource_tracker.sh

### 3. Configure AWS CLI (if not done already)

bash
aws configure

### 4. SES Email Setup

Ensure you verify both the sender and recipient emails in AWS SES. I have used the same mail id for both.

In the script, configure the same

## ▶️ How to Run

Run the script manually:

bash:
./resource_tracker.sh

A new log file will be created and pushed to GitHub. An email will be sent confirming the action.

## 📖 Explanation of Key Commands Used
----------------------------------------------------------------------
| Command             | Purpose                                      |
|---------------------|----------------------------------------------|
| free -h             | Displays memory usage in human-readable form |
| df -h               | Displays disk space usage                    |
| df -i               | Shows inode availability                     |
| lscpu               | CPU architecture and stats                   |
| ip addr             | Shows network interface and IP info          |
| top -b -n 1         | Snapshot of top processes (batch mode)       |
| dmesg | tail        | Shows last 10 kernel logs                    |
| aws ses send-email  | Sends an email alert using AWS SES           |
| git add/commit/push | Commits log and pushes to GitHub             |
----------------------------------------------------------------------

## 📧 Example Email Sent

> **Subject:** ✅ EC2 Resource Log #1 Created  
> **Body:** Log #1 was created on ip-X.X.X.X at 2025-07-07 14:00:00

## 🙋‍♂️ Contact

For queries or contributions, feel free to connect via [LinkedIn](https://www.linkedin.com/in/shree-harini-km?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app) or raise an issue in the GitHub repo.

## 📎 License

This project is licensed under the [MIT License](LICENSE).
