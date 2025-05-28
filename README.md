# terraform-template-app
A secure web app for downloading Terraform templates using Azure Blob Storage and SAS tokens.

# 🌐 Terraform Template App (Azure + Docker + SAS Tokens)

This project demonstrates a secure file download web app that allows users to access Terraform templates via a clickable UI. It leverages Docker, Azure App Service, Blob Storage integration, and SAS tokens for secure access control.

---

## ✅ Why This Project?

The purpose of this project is to showcase the implementation of a secure web application that facilitates downloading pre-configured Terraform templates through a secure, SAS-protected Azure Blob Storage. It emphasizes security best practices in cloud architecture, including Docker containerization, Azure App Service deployment, and token-based access management.

---

## ✅ Features

* Dockerized frontend web UI (HTML/CSS/JavaScript)
* Azure App Service (Linux) hosting with HTTPS enforcement
* Secure downloads using SAS Tokens for Azure Blob Storage
* Modular architecture for easy template updates and scaling
* Environment variable management for dynamic download links

---

## 🛠️ Architecture Overview

```
[User Browser]
↓ HTTPS
[Azure App Service]
↓ (Docker container)
[Frontend Web UI]
↓
[Azure Blob Storage]
↓ (SAS Token protected access)
[Terraform .tf File Downloads]
```

---

## 📦 Project Structure

```
terraform-template-manager/
├── README.md
├── LICENSE
├── .gitignore
├── /src/
│   ├── frontend/
│   │   ├── index.html
│   │   ├── frontend.css
│   │   └── app.js
│   └── backend/
│       └── file1.tf
        └── file2.tf
        etc...

├── /docs/
│   ├── architecture.png
│   └── implementation-steps.md
├── /assets/
│   └── demo.gif
```

---

## 🚀 Deployment Steps

### ✅ 1. Clone This Repository

```bash
git clone https://github.com/yourusername/terraform-template-manager.git
cd terraform-template-manager
```

### ✅ 2. Update the index.html with SAS Token

Open `src/frontend/index.html`

Replace `YOUR_SAS_TOKEN` with the actual SAS token generated in the later steps.

### ✅ 3. Build Docker Image

```bash
docker build -t terraform-webapp .
```

### ✅ 4. Create Azure Container Registry (ACR)

```bash
az acr create --resource-group <resource-group> --name <acr-name> --sku Basic --location <location> --admin-enabled true
```

### ✅ 5. Login to ACR and Push Docker Image

```bash
az acr login --name <acr-name>
docker tag terraform-webapp <acr-name>.azurecr.io/terraform-webapp:v1
docker push <acr-name>.azurecr.io/terraform-webapp:v1
```

### ✅ 6. Create Azure Storage Account and Container

```bash
az storage account create --name <storage-name> --resource-group <resource-group> --location <location> --sku Standard_LRS
az storage container create --account-name <storage-name> --name templates --public-access blob
```

### ✅ 7. Upload .tf Files to Blob Storage

```bash
az storage blob upload-batch --account-name <storage-name> --destination templates --source ./src/templates
```

### ✅ 8. Generate SAS Token for Secure Downloads

```bash
az storage container generate-sas --account-name <storage-name> --name templates --permissions r --expiry <expiry-date> --output tsv > sastoken.txt
```

Copy the SAS token and update it in `index.html`.

### ✅ 9. Create App Service Plan and Web App

```bash
az appservice plan create --name <app-service-plan> --resource-group <resource-group> --sku B1 --is-linux
az webapp create --name <webapp-name> --resource-group <resource-group> --plan <app-service-plan> --deployment-container-image-name <acr-name>.azurecr.io/terraform-webapp:v1
```

### ✅ 10. Enforce HTTPS

```bash
az webapp update --name <webapp-name> --resource-group <resource-group> --set httpsOnly=true
```

### ✅ 11. Testing and Verification

Visit the deployed web app at:

```
https://<webapp-name>.azurewebsites.net
```

Verify that the download buttons work and the `.tf` files download using the SAS token.

---

## ✅ Key Learnings and Takeaways

* Implemented secure access using Azure SAS tokens to protect Terraform templates.
* Leveraged Azure App Service for Linux to host the Dockerized frontend application.
* Applied security best practices in managing access to Blob Storage.
* Practiced Azure CLI commands for deployment and management of cloud resources.

---

## ✅ Challenges and Solutions

* **Issue:** Azure Blob Storage returned a `PublicAccessNotPermitted` error.

  * **Solution:** Updated the storage container permissions and SAS token scope.

* **Issue:** Docker container failed to start due to incorrect ACR credentials.

  * **Solution:** Validated and refreshed ACR credentials using the Azure CLI.

---

## 👨‍💻 Author

Built by Gideon Bennett — showcasing skills in Azure, Terraform, Docker, and cloud security.
