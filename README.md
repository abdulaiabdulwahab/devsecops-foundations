# devsecops-foundations

# DevSecOps Foundations Project

## Overview

This project is a beginner-friendly introduction to **DevSecOps**.

The goal is to learn how security checks can be integrated into the software development lifecycle before an application is deployed.

The project contains intentionally insecure application code, Terraform configuration, dependencies, and a Dockerfile so that different security tools can detect vulnerabilities and misconfigurations.

---

## Objectives

By completing this project, I practiced:

- Static Application Security Testing (SAST)
- Dependency vulnerability scanning
- Secret scanning
- Infrastructure as Code security scanning
- Docker container security scanning
- Security quality gates
- Vulnerability remediation

---

## Tools Used

- **Git** – Source control
- **Python / Flask** – Sample application
- **Bandit** – Python SAST scanning
- **Checkov** – Terraform and IaC security scanning
- **Trivy** – Dependency, secret, configuration, and container scanning
- **Terraform** – Infrastructure as Code
- **Docker** – Containerization

---

## Project Structure

```text
devsecops-foundations/
│
├── app/
│   └── app.py
│
├── infra/
│   └── main.tf
│
├── requirements.txt
├── Dockerfile
├── .gitignore
└── security-scan.sh
```

---

## Security Checks

### 1. SAST Scan

Bandit was used to scan the Python application for insecure code.

```bash
bandit -r app
```

Example issues included unsafe use of shell commands and untrusted user input.

---

### 2. Terraform Security Scan

Checkov was used to scan Terraform configuration for security misconfigurations.

```bash
checkov -d infra
```

One example was an NSG rule allowing SSH access from any IP address.

---

### 3. Dependency, Secret, and Configuration Scan

Trivy was used to scan the project directory.

```bash
trivy fs \
  --scanners vuln,secret,misconfig \
  .
```

This checks for:

- Vulnerable dependencies
- Exposed secrets
- Infrastructure misconfigurations

---

### 4. Security Quality Gate

The scan was configured to fail when HIGH or CRITICAL vulnerabilities were detected.

```bash
trivy fs \
  --scanners vuln,secret,misconfig \
  --severity HIGH,CRITICAL \
  --exit-code 1 \
  .
```

This demonstrates how DevSecOps tools can stop insecure software from progressing through a CI/CD pipeline.

---

## Docker Security

The application was packaged into a Docker image.

```bash
docker build \
  -t devsecops-foundations:v1 \
  .
```

The image was then scanned with Trivy.

```bash
trivy image \
  devsecops-foundations:v1
```

A security gate can also be enforced:

```bash
trivy image \
  --severity HIGH,CRITICAL \
  --exit-code 1 \
  devsecops-foundations:v1
```

---

## Automated Security Scan

A simple script was created to run multiple security checks.

```bash
./security-scan.sh
```

The script runs:

```text
Bandit
   ↓
Checkov
   ↓
Trivy
   ↓
PASS / FAIL
```

If a serious vulnerability is detected, the script stops.

---

## Remediation

The vulnerabilities discovered during the project were remediated by:

- Removing unsafe shell execution
- Validating application input
- Updating vulnerable dependencies
- Restricting SSH access in Terraform
- Removing exposed secrets
- Running the Docker container as a non-root user
- Rescanning the project after each fix

---

## DevSecOps Workflow

```text
Write Code
    ↓
Security Scan
    ↓
Vulnerability Found
    ↓
Remediate
    ↓
Rescan
    ↓
Security Checks Pass
```

This demonstrates the DevSecOps principle of **shifting security left**, where vulnerabilities are identified earlier in the development lifecycle.

---

## Key Takeaways

This project helped me understand how security tools can be integrated into a development workflow instead of relying only on security testing after deployment.

The main concepts practiced were:

- SAST
- SCA
- Secret scanning
- IaC security
- Container security
- CVEs
- Security gates
- Shift-left security
- Vulnerability remediation

---

## Next Step

The next project builds on these concepts by integrating security scanning directly into an **Azure DevOps CI/CD pipeline**, where insecure code or containers can automatically cause the pipeline to fail.