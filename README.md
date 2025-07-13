#Twitter_clone-project
# 🌩️ Full-Stack DevOps AWS Infrastructure 🚀

Welcome to the **Terraform-Powered AWS & DevOps Automation Suite** — an end-to-end, enterprise-grade solution for launching secure, production-ready infrastructure on AWS. This project orchestrates **Terraform, AWS EC2, EKS (Kubernetes), Jenkins, Nexus, SonarQube**, and more — with just a few commands.

> **🔥 From Infrastructure to CI/CD to Monitoring — All in One Repo!**

---

## ✨ Key Features

🔧 **Terraform IaC**  
Provision AWS EC2 instances, EKS clusters, IAM roles, and networking with reusable Terraform modules.

🧱 **EKS Kubernetes Cluster**  
Includes Kubernetes resource manifests (`role.yml`, `bind_role.yml`, `service_account.yml`, `token.yml`) for secure access control and workload deployment.

📦 **CI/CD Automation**  
Shell scripts to bootstrap **Jenkins**, **Nexus**, and **SonarQube** — your full DevOps pipeline in minutes:
- `jenkins.sh`
- `nexus.sh`
- `sonarqube.sh`

🐳 **Docker + Kubernetes**  
Containerize Java apps and deploy with provided `Dockerfile`, K8s YAMLs, and ingress configuration.

🔐 **Secrets & Config Management**  
Includes `secret.txt`, `.gitignore`, and `.gitattributes` for secure version control and Git LFS integration.

📁 **Project includes:**
- ✅ Terraform state tracking
- ✅ Terraform variable & output management
- ✅ GitHub Git LFS setup for `.jar` artifacts
- ✅ Pre-downloaded `kubectl` for portability

---

## 🗂️ Folder & File Structure

