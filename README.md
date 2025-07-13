🌩️ Full-Stack DevOps AWS Infrastructure 🚀
Welcome to the Terraform-Powered AWS & DevOps Automation Suite — an end-to-end, enterprise-grade solution for launching secure, production-ready infrastructure on AWS. This project orchestrates Terraform, AWS EC2, EKS (Kubernetes), Jenkins, Nexus, SonarQube, and more — with just a few commands.

🔥 From Infrastructure to CI/CD to Monitoring — All in One Repo!


## ✨ Features

### 🎯 Application Highlights
- 🔐 User Authentication & Authorization (Spring Security)
- 📝 Create, read, and manage tweets
- 🗂️ REST APIs with MVC architecture
- 📦 Maven-based build system
- 🖼️ Fully functional frontend with HTML templates

### ⚙️ DevOps & Cloud
- 🌍 AWS provisioning with **Terraform**
- ☸️ Kubernetes cluster on **EKS**
- 🐳 Dockerized services
- 🔁 Jenkins CI/CD pipeline
- 📊 SonarQube for code analysis
- 🎯 Nexus for artifact storage
- 🌐 Ingress with TLS (HTTPS-ready)

---

## 🧱 Tech Stack

| Layer              | Tools / Tech                            |
|-------------------|------------------------------------------|
| 👨‍💻 Backend         | Java, Spring Boot, Maven                |
| 📦 Build & CI/CD    | Jenkins, Docker, Nexus, SonarQube      |
| ☁️ Infrastructure   | AWS EC2, EKS, Terraform                |
| 🔒 Security         | Spring Security, TLS, RBAC             |
| 📊 Testing & Reports| JUnit, Jacoco, Surefire                |

---

## 🗂️ Directory Structure
twitter_clone/
├── aws_instances/ → Infrastructure provisioning with Terraform
│ ├── awsinstance.tf
│ ├── terraform.tfstate*
│ ├── jenkins.sh, nexus.sh, sonarqube.sh
│ └── EKS_CLUSTER/ → Kubernetes cluster & service account
│ ├── main.tf, variables.tf, role.yml, etc.
├── src/
│ ├── main/
│ │ ├── java/com/example/twitterapp/
│ │ │ ├── config/ → Spring Security config
│ │ │ ├── controller/ → User & post APIs
│ │ │ ├── model/ → Post & User entities
│ │ │ ├── repository/ → Spring Data JPA
│ │ │ └── service/ → Business logic layer
│ │ └── resources/
│ │ ├── application.properties
│ │ ├── static/images/ → Background image
│ │ └── templates/ → HTML pages (add, home, login, register)
│ └── test/
│ └── java/...Tests.java
├── target/ → Compiled classes, test reports, jacoco, .jar
│ ├── site/jacoco/ → Test coverage reports
│ ├── surefire-reports/ → JUnit test results
│ └── twitter-app-5.1.1.jar
├── Dockerfile
├── pom.xml
├── cert-auth.yml → Kubernetes TLS certificate secret
├── deployment-service.yml → Kubernetes Deployment & Service
├── ingress_resource.yml → Ingress controller for routing
├── terraform.tfstate → Infrastructure state tracking
├── jenkins_pipeline.txt, maven_config.txt
├── mvnw, mvnw.cmd → Maven wrapper
└── README.md

---

## 🚀 Getting Started

### ✅ Prerequisites

- Java 17+
- Maven
- Docker
- AWS CLI + IAM access
- Terraform
- kubectl
- Jenkins, SonarQube & Nexus (or install via provided shell scripts)

---

## 🧪 Run Locally (Dev Environment)


# Clone the repo
git clone https://github.com/<your-username>/twitter_clone.git
cd twitter_clone

🧪 Testing & Code Quality
Run tests: ./mvnw test

Coverage report: target/site/jacoco/index.html

SonarQube analysis integrated with Jenkins pipeline

📊 CI/CD Workflow (via Jenkins)
🔍 Run SonarQube for code quality check

🧪 Run test cases and generate coverage report

⚙️ Build .jar with Maven

🐳 Create Docker image and push to registry

☸️ Deploy to Kubernetes via kubectl

🔒 Security
Enforced RBAC with Kubernetes Service Accounts

HTTPS via Ingress TLS (cert-auth.yml)

Spring Security for login/auth

Secrets excluded via .gitignore

📬 Contact
For feedback, suggestions, or collaboration:

📧 Gaurav
🔗 github.com/Gauravxo

⭐ Show Your Support
If you liked this project:

Give it a ⭐ on GitHub

Share it with others

Fork it and build your own version!

📝 License
This project is for learning and demonstration purposes only.
For reuse or commercial use, please contact the author.

# Build and run Spring Boot app
./mvnw clean install
./mvnw spring-boot:run



