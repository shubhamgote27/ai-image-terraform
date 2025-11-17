# AI Image Generator - DevOps Infrastructure 🚀✨

This repository contains the complete **Terraform** code to build, deploy, and monitor a scalable **AI Image Generator** application platform on **AWS**.

The primary goal of this project is to demonstrate a robust, automated DevOps lifecycle using:
* **Infrastructure as Code (IaC):** For repeatable and version-controlled environments.
* **CI/CD Automation:** For seamless code-to-deployment pipelines.
* **Full-Stack Observability:** For real-time monitoring, logging, and alerting.

This setup is designed to be a production-ready blueprint, perfect for handling a modern, containerized application.

---

## 🏛️ High-Level Architecture


**The high-level workflow is as follows:**
1.  **IaC:** A developer defines all infrastructure (VPC, servers, networking) in **Terraform**.
2.  **Provisioning:** `terraform apply` provisions the entire AWS platform, including EC2 instances for Jenkins, Prometheus, and Grafana.
3.  **Code Push:** A developer pushes new application code to the GitHub repository.
4.  **CI/CD Pipeline:** A GitHub webhook triggers a **Jenkins** job.
5.  **Build & Containerize:** Jenkins checks out the code, builds it, and creates a **Docker** image.
6.  **Publish Artifact:** The new Docker image is pushed to a container registry (like AWS ECR).
7.  **Deploy:** Jenkins deploys the new image to the application servers.
8.  **Monitor:** **Prometheus** continuously scrapes metrics from all instances, and **Grafana** visualizes this data and system logs in a central dashboard.

---

## 🛠️ Technology Stack

| Category | Technology | Purpose |
| :--- | :--- | :--- |
| **Cloud** | **AWS** | The cloud platform providing all core services. |
| **IaC** | **Terraform** | 🏗️ For provisioning and managing all cloud infrastructure as code. |
| **CI/CD** | **Jenkins** | 🔄 The automation server for building, testing, and deploying the application. |
| **Containerization** | **Docker** | 🐳 For packaging the application and its dependencies into a portable container. |
| **Git** | **GitHub** |  VCS and the trigger for the entire CI/CD pipeline. |
| **Monitoring** | **Prometheus** | 📈 A powerful time-series database for collecting metrics. |
| **Observability** | **Grafana** | 📊 For visualizing metrics, logs, and creating health dashboards. |

---

## 🏗️ What the Terraform Code Provisions

This Terraform configuration builds the entire environment from the ground up, including:

* **Networking:**
    * Custom **VPC** with public and private subnets across multiple Availability Zones.
    * Internet Gateway, NAT Gateways, and Route Tables for secure network traffic.
* **Compute (EC2):**
    * A dedicated **Jenkins** server instance.
    * A dedicated **Prometheus** server instance.
    * A dedicated **Grafana** server instance.
    * **(Assuming)** An EC2 Auto Scaling Group or ECS Cluster to run the final AI Image Generator application.
* **Security:**
    * Fine-grained **Security Groups** to control traffic between all components.
    * **IAM Roles** with least-privilege permissions for Jenkins and other services.
* **Storage (Optional but Recommended):**
    * **S3 Bucket** for storing the Terraform remote state (`tfstate`).
    * **AWS ECR** (Elastic Container Registry) to store the built Docker images.

---

## 🚀 The CI/CD & Observability Pipeline

This project demonstrates a mature "you build it, you run it" philosophy.

### 1. The CI/CD Flow (Jenkins + Docker)
The `Jenkinsfile` (or Jenkins job configuration) is the heart of our automation. It's configured to:
1.  **Listen** for changes to the application repository.
2.  **Checkout** the latest code.
3.  **Build** the application and run any unit tests.
4.  **Build a new Docker image** using the provided `Dockerfile`.
5.  **Push** the tagged image to our private container registry.
6.  **Deploy** the new image to the application environment, ensuring zero-downtime.

### 2. The Observability Flow (Prometheus + Grafana)
We don't just deploy code; we monitor its health.
* **Prometheus** is configured to auto-discover and scrape metrics from all our key instances (Jenkins, the app servers, etc.).
* **Grafana** is connected to Prometheus as a data source. It provides a "single-pane-of-glass" dashboard to monitor:
    * System Health (CPU, Memory, Disk I/O)
    * Application-specific metrics (e.g., image generation time, error rates)
    * Jenkins build statuses and pipeline health.

---

## 💻 How to Use This Repository

These are the steps to deploy this entire platform yourself.

### Prerequisites
* [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) CLI installed.
* An [AWS Account](https://aws.amazon.com/free/).
* [AWS CLI](https://aws.amazon.com/cli/) configured with your credentials (or an IAM role).

### Deployment Steps
1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/shubhamgote27/ai-image-generator-devops.git](https://github.com/shubhamgote27/ai-image-generator-devops.git)
    cd ai-image-generator-devops
    ```

2.  **Initialize Terraform:**
    This will download the required AWS provider plugins.
    ```bash
    terraform init
    ```

3.  **Create a variables file (optional but recommended):**
    Create a file named `terraform.tfvars` and populate it with any required variables (like your desired AWS region or instance types).
    ```hcl
    # terraform.tfvars
    aws_region = "us-east-1"
    # ... other variables
    ```

4.  **Plan the deployment:**
    This command shows you exactly what Terraform *will* create.
    ```bash
    terraform plan
    ```

5.  **Apply the configuration:**
    This will build the entire infrastructure on AWS. Type `yes` when prompted.
    ```bash
    terraform apply
    ```

### Cleaning Up
When you are finished, you can destroy all the resources created to avoid incurring further AWS costs.
```bash
terraform destroy
