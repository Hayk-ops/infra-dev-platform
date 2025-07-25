📄 README.md (copy this into your repo root)
markdown
Copy
Edit
# 🌐 infra-dev-platform

Modular, secure infrastructure project using **Terraform** on **Azure**, ready for full CI/CD, Kubernetes, and cloud-native tools like ArgoCD and Helm.

---

## 📦 Project Features

- ✅ Modular Terraform setup (root + core modules)
- ✅ Azure Key Vault with secret management
- ✅ Azure Linux VM with NGINX
- ✅ NSG rules for HTTP + SSH
- ✅ Custom certificate + TLS integration
- ✅ Clean remote backend (Azure Storage)
- ✅ GitHub-ready, CI-compatible structure

---

## 📁 Folder Structure

Terraform+Azure_project/
├── main.tf
├── terraform.tfvars
├── variables.tf
├── outputs.tf
├── .gitignore
├── module/
│ ├── core_modules/
│ └── vm_stack/
└── .github/
└── workflows/

yaml
Copy
Edit

---

## 🚀 Next Goals

- [ ] Add CI pipeline (`terraform fmt`, `validate`, `plan`)
- [ ] Connect GitHub → Azure (OIDC or SPN)
- [ ] Add ArgoCD, Helm charts, Kubernetes manifests
- [ ] Serve a web app behind HTTPS + domain

---

## 🧠 Notes

- `.terraform/`, `*.tfstate`, `*.plan`, `*.pem` are ignored
- Secrets removed from Git history using `git filter-repo`
- State backend secured via Key Vault + Azure Storage

---

## 🔐 Author

**Hayk** — DevOps / Infra-as-Code Engineer  
🇦🇲 Based in Armenia | ☁️ Terraform, Azure, GitHub Actions
