Linux Security Checker

1. Project Description

The Linux Security Checker is a Bash script that performs basic security checks on a Linux system. It helps a user review selected security settings and displays results such as PASS, WARNING, INFO, or ERROR.

This project is intended for learning and basic system-checking purposes. It does not replace a professional security audit.

 2. Features

The script can check:

- Firewall status — checks whether a supported firewall tool is available and whether the firewall is active.
- Root account status — checks the status reported by the Linux `passwd` command.
- SSH service status — checks whether the SSH service is running.
- Important file permissions — displays permissions for `/etc/passwd`, `/etc/shadow`, and `/etc/group`.
- Command-line options and help — allows individual checks, all checks, or the help message to be run.

 3. Requirements

- A Linux system with Bash.
- Standard utilities used by the script, such as `grep`, `awk`, `stat`, and `systemctl`.
- `sudo` permission may be required for some checks.
- A supported firewall utility, such as `ufw` or `firewall-cmd`, is needed for the corresponding firewall check.

Some commands or configuration files may not be available on every Linux distribution. The script should report when a tool or file is not found.

 4. How to Run

Save the script as `SecurityChecker.sh` in your chosen directory, then open a terminal in that directory.

Run an individual check:

```
bash SecurityChecker.sh --firewall
bash SecurityChecker.sh --root
bash SecurityChecker.sh --ssh
bash SecurityChecker.sh --permissions
```

Run all checks:

```
bash SecurityChecker.sh --all
```

Display the help message:

```
bash SecurityChecker.sh --help
```

Alternatively, make the script executable once:

```
chmod +x SecurityChecker.sh
```

Then run it with:

```
./SecurityChecker.sh --all
```

 5. Understanding the Results

- [PASS] — the check did not find the specific issue it was looking for.
- [WARNING] — the setting may need review; a warning does not automatically mean the system has been compromised.
- [INFO] — the script is providing information or cannot make a definite judgment.
- [ERROR] — a required command, file, or operation was unavailable or failed.

 6. Important Notes

- Run the script only on a system you own or are authorized to inspect.
- Some checks use `sudo`, so the terminal may ask for your password.
- The script reports information; it does not automatically change firewall settings, lock accounts, or modify SSH configuration.
- The file-permission check is a basic review. A write permission is not automatically a security problem; the user and group that have the permission matter.
- The exact output can differ between Linux distributions and configurations.

 7. Project Objective

The objective of this project is to practise Bash scripting, functions, command-line arguments, conditional statements, loops, Linux commands, input handling, and readable output while learning basic Linux security concepts.

8. Screenshot
   (SecurityChecker_Output.png)

 9. Author

Kelvin Apodi — Linux Security Checker.
