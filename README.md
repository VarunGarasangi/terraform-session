# 🌍 Terraform Multi-Account (Dev & Prod) Multi-Region Infrastructure

## 📌 Overview
This project manages AWS infrastructure using Terraform across **two AWS accounts (dev and prod)** and **multiple regions**. It follows best practices such as modular design, remote state management, and environment isolation.

---

## 🏗️ Architecture Design

### 🔹 Multi-Account Strategy

Two separate AWS accounts are used:

#### Dev Account
- Used for development and testing  
- Less restrictive access  
- Frequent changes  

#### Prod Account
- Used for production workloads  
- Highly restricted access  
- Stable and controlled deployments  

---

### 🔹 Multi-Region Strategy

Infrastructure is deployed across multiple regions such as:

- `us-east-1`
- `ap-south-1`

#### Benefits:
- High availability  
- Disaster recovery  
- Reduced latency  

---

## 📂 Project Structure
```bash
terraform-project/
│
├── modules/
│ ├── vpc/
│ ├── ec2/
│ ├── alb/
│ └── s3/
│
├── environments/
│ ├── dev/
│ │ ├── us-east-1/
│ │ │ ├── vpc/
│ │ │ ├── ec2/
│ │ │ └── terraform.tfvars
│ │ └── ap-south-1/
│ │ ├── vpc/
│ │ └── ec2/
│
│ └── prod/
│ ├── us-east-1/
│ │ ├── vpc/
│ │ ├── ec2/
│ │ └── terraform.tfvars
│ └── ap-south-1/
│ ├── vpc/
│ └── ec2/
│
├── global/
│ ├── iam/
│ └── route53/
│
└── backend/
└── backend.tf
```


## 🔐 State Management

### 📦 Backend Setup

Terraform uses:
- **Amazon S3** → store state files  
- **DynamoDB** → state locking  

---

### 🧾 Backend Configuration Example

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "dev/us-east-1/vpc/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
```


## 📁 State File Structure
Each component has its own state file:
```text
<account>/<region>/<service>/terraform.tfstate
```

✅ Examples:
```
dev/us-east-1/vpc/terraform.tfstate
dev/ap-south-1/ec2/terraform.tfstate
prod/us-east-1/alb/terraform.tfstate
prod/ap-south-1/vpc/terraform.tfstate
```
✅ Why Separate State Files?
```
Prevents conflicts
Safer deployments
Faster execution
Easier troubleshooting
```
## ⚙️ Configuration
📄 Dev terraform.tfvars
```hcl
region       = "ap-south-1"
aws_profile  = "dev"
environment  = "dev"
```
📄 Prod terraform.tfvars
```hcl
region       = "ap-south-1"
aws_profile  = "prod"
environment  = "prod"
```
## 🔑 AWS Authentication
Configure AWS CLI profiles:
```hcl
aws configure --profile dev
aws configure --profile prod
```
## 📦 Best Practices
```
- Use separate AWS accounts for dev and prod
- Keep separate state files per service
- Never commit .tfstate files
- Use modules for reusable code
- Always review terraform plan
- Restrict production access
```
## ⚠️ Important Notes
```
Always verify correct AWS profile before running Terraform
Do not hardcode secrets
```
Use .gitignore:
```
.terraform/
*.tfstate
*.tfstate.backup
```
