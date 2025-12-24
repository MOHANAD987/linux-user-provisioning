

# Linux User Provisioning Automation 🐧

A robust, enterprise-grade Bash automation tool for bulk user creation and management on Linux systems. This project streamlines the onboarding process by automating user account setup, secure password generation, and logging.

---

## 🔹 Project Context

* **Cloud Provider:** AWS EC2
* **Operating System:** Ubuntu Server
* **Access Method:** SSH via MobaXterm

---

## 🔹 Features

* **Interactive Data Collection:** `collect_user_data.sh` allows manual entry and confirmation of user details before saving.
* **Bulk Provisioning:** Automates account creation for multiple users using CSV input files.
* **Enhanced Security:** * Generates strong, random initial passwords.
* Forces password change on the first login.
* Includes a **Root Privilege Check** to ensure secure execution.


* **Dry Run Mode:** Test the script logic without making actual system changes.
* **Comprehensive Logging:** Tracks every operation in `user_creation.log` and `audit.log` for accountability.

---

## 🔹 Project Structure
Plaintext:


linux-user-provisioning/
├── scripts/
│   ├── collect_user_data.sh    # Interactive data collection script
│   └── create_users.sh         # Core provisioning engine
├── data/
│   ├── employee.csv            # Input source (Username, Full Name)
│   └── users_credentials.txt   # Output of generated login info
├── logs/
│   ├── user_creation.log       # Execution history
│   └── audit.log               # Detailed system audit logs
└── README.md


```

---

## 🔹 How It Works

### 1. Data Collection

Run `collect_user_data.sh` to populate your CSV file. The script asks for:

* Username
* Full Name
* Confirmation before saving

### 2. User Provisioning

Execute the main script with root privileges:

bash
sudo ./create_users.sh

```

The script will:

1. Verify root access.
2. Read user data from `data/employee.csv`.
3. Create the user with a home directory and default shell.
4. Generate and apply a random password.
5. Set the account to expire the password immediately, forcing a reset upon first `su` or login.

---

## 🔹 Usage Options

| Command | Description |
| --- | --- |
| `sudo ./create_users.sh` | Run the full provisioning process. |
| `./create_users.sh --dry-run` | Enable Dry Run mode to validate logic without creating users. |

---

## 📜 License

This project is licensed under the **MIT License**.

---

