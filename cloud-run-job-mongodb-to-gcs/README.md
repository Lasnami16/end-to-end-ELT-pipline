# End-to-End ELT Pipeline: MongoDB to GCS

This project provides a complete ETL pipeline to export data from MongoDB and upload it to Google Cloud Storage (GCS). It is designed for easy local development and secure production deployment using Docker and Terraform-managed GCP infrastructure.

---

## 1. Infrastructure Setup (`infra/`)

- All GCP resources (GCS bucket, service accounts, credentials) are managed via Terraform in the `infra/` folder.
- Service account keys are generated in `infra/gcp_credentials/` and **excluded from Docker images** via `.dockerignore`.
- To provision resources:
  1. Edit `infra/terraform.tfvars` with your GCP project info.
  2. Run:
     ```sh
     cd infra
     terraform init
     terraform apply
     ```
  3. Use the generated service account key for Docker authentication.

---

## 2. Local Development

- By default, the project can run locally using your authenticated gcloud CLI user.
- Make sure you have run:
  ```sh
  gcloud auth application-default login
  ```
- The Python code will use your local gcloud credentials for GCS access.

---

## 3. Running in Docker (Production/CI/CD)

- **You must use a service account key for GCS authentication in Docker.**
- Mount the key and set the environment variable:
  ```sh
  docker run --env-file .env \
    -v /absolute/path/to/infra/gcp_credentials/etl-gcs-uploader-credentials.json:/app/credentials.json \
    -e GOOGLE_APPLICATION_CREDENTIALS=/app/credentials.json \
    mongodb-to-gcs-job
  ```
- This ensures your container uses the correct credentials and keeps secrets out of the image.

---

## 4. Security & Best Practices

-  docker build -t mongodb-to-gcs-job .  
- `.dockerignore` excludes `infra/` and all secrets from Docker builds.
- Never commit real credentials or `.env` files to source control.
- Use least privilege for IAM roles and rotate keys regularly.

---

## 5. Troubleshooting

- For local auth errors, check your gcloud login and ADC setup.
- For Docker auth errors, verify the service account key is mounted and `GOOGLE_APPLICATION_CREDENTIALS` is set.

---

## 6. Contributing

- Fork, clone, and follow the infra setup.
- Open PRs for improvements or bug fixes.

---

## 7. License
MIT
