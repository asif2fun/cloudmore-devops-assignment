# Cloudmore DevOps Assignment

This project is a home assignment for the **DevOps Engineer** position. The goal is to provision infrastructure, deploy a weather-exporter service, and monitor temperature data using **Prometheus** and **Grafana**, all automated through **Terraform** and **Docker**.

## 🚀 Project Overview

- Provision an Ubuntu VM in **Azure** using Terraform.
- Automatically install and configure **Docker**, **Prometheus**, **Grafana**, and required Python dependencies with the use of **setup-instance.sh** script.
- Use a custom Python script to query the **OpenWeatherMap API** for current temperature in **Tallinn**.
- Expose temperature metrics on `/metrics` and scrape them using **Prometheus**.
- Visualize the metrics with a dashboard in **Grafana**.

---

## 🧰 Tech Stack

| Component        | Tool / Service        |
|------------------|------------------------|
| IaC              | Terraform              |
| Cloud Provider   | Microsoft Azure        |
| VM OS            | Ubuntu 22.04 LTS       |
| Container Engine | Docker (Compose)       |
| Monitoring       | Prometheus             |
| Dashboarding     | Grafana                |
| Language         | Python (Flask app)     |
| Weather API      | OpenWeatherMap (OWM)   |

---

## 📁 Project Structure

```
.
├── grafana-dashboard-json-model/
│   └── tallinn-temperature-dashboard.json
├── terraform/
│   ├── main.tf
│   ├── setup-instance.sh
│   ├── variables.tf
│   └── ...
├── weather-app/
│   ├── weather-app.py
│   ├── Dockerfile
│   └── requirements.txt
├── docker-compose.yml
├── prometheus.yml
├── .env.example     # Example for API key
├── .gitignore
└── README.md
```

---

## 🔐 Security Best Practices

- ✅ `.env` file (contains secrets like OWM API key) is **gitignored**.
- ✅ A safe `.env.example` file is committed to show the expected format.
- ✅ Terraform state files and backups are excluded from version control.
- ✅ `.tfvars` files are excluded by default.
- ✅ Secrets are not hardcoded in scripts or Terraform files.
- ✅ Clear directory separation between infra, app, and config.

---

## 📦 Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/asif2fun/cloudmore-devops-assignment
cd cloudmore-devops-assignment
```

### 2. Configure .env
Create a real .env file from the example and add your OpenWeatherMap API key:

Edit the .env file and set your OpenWeatherMap API key:

```bash
cp .env.example .env
Edit .env:

OWM_API_KEY=your_api_key_here
```
You can get a free API key at: https://openweathermap.org/

### 3. Provision Infrastructure (Azure)
Ensure your Azure CLI is authenticated Make sure you're logged into Azure CLI:

```bash
az login
```
Then:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

This creates a resource group, VNet, public IP, network interface, security group, and VM. The VM installs Docker and auto-clones the repo to launch the weather monitoring stack.

## 🐳 Running the Weather App (on VM)
SSH into your Azure VM:

```bash
ssh asifadmin@<your-vm-ip>
```
Clone the repo inside the VM, then navigate to the cloned repo and edit .env:

```bash
git clone https://github.com/asif2fun/cloudmore-devops-assignment.git
cd cloudmore-devops-assignment
cp .env.example .env
nano .env   # <-- Add your OpenWeatherMap API key here
```

Run setup-instance.sh if not ran automatically while infrastructure is built. 

```bash
cd cloudmore-devops-assignment/terraform/
sudo ./setup-instance.sh
```
Note: Only run this manually if the automatic provisioning via custom_data in Terraform didn’t execute during VM creation.

Once you're inside the VM and the repository is in place:

```bash
cd cloudmore-devops-assignment
docker compose up --build -d
```
This will build the Flask weather exporter, and start Prometheus, Grafana, and your custom weather service in Docker containers.

## 📈 Accessing the Services
Service	URL (replace <IP> with your VM's public IP)

Weather Exporter Metrics:	

Weatherapp  http://<IP>:5000/metrics
Prometheus	http://<IP>:9090
Grafana	    http://<IP>:3000

Example: 

http://108.143.124.44:3000/login      # Used to log into Grafana and view dashboards.
http://108.143.124.44:9090/query      # Run Prometheus queries (e.g., tallinn_temperature_celsius).
http://108.143.124.44:9090/targets    # Verify if Prometheus is scraping the weather exporter successfully.
http://108.143.124.44:5000/metrics    # Raw metrics exposed by the Flask app (used by Prometheus).


Default Grafana Login
Username: admin
Password: admin (or set one via provisioning)


## 📊 Accessing Grafana and Visualizing the Dashboard
A sample dashboard JSON is available in: grafana-dashboard-json-model/tallinn-temperature-dashboard.json

You can import this manually via Grafana UI to visualize the Tallinn temperature metric: tallinn_temperature_celsius.

Open Grafana in your browser using your VM's public IP:
http://<your-vm-ip>:3000

Login credentials (first time):
Username: admin
Password: admin

After the first login, you will be prompted to change your password.

Once logged in:

Click “+” ➜ “Import”

Upload the file from:
grafana-dashboard-json-model/tallinn-temperature-dashboard.json

Choose Prometheus as the data source

Click Import

You should now see a real-time graph of the temperature in Tallinn under the metric:
**tallinn_temperature_celsius**



✅ Features Implemented
 VM provisioning via Terraform

 Docker & Python setup automation

 Flask app exporting metrics to Prometheus

 Prometheus scraping and target verification

 Grafana dashboard visualization

## 🧹 Cleanup
To remove all Azure resources:

```bash
cd terraform
terraform destroy
```

## 🤝 Contact
Asif Ahmed
DevOps Engineer
LinkedIn Profile: https://www.linkedin.com/in/asif-ahmed-devops-engineer/