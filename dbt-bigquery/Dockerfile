FROM ghcr.io/dbt-labs/dbt-bigquery:1.8.2


WORKDIR /app

# Copy your project files to the container
COPY . .

# Set the SERVICE_ACCOUNT environment variable
#ENV SERVICE_ACCOUNT=/app/credentials.json

# dbt command to run the project
ENTRYPOINT ["dbt", "build", "--profiles-dir", "/app/dbt_translations_marts", "--project-dir", "/app/dbt_translations_marts"]