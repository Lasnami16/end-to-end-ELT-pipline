Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices



### export env variables:
$env:PROJECT_ID="wissem-school"
$env:DBT_DATASET_DEV="translations_dev" 
$env:KEYPATH_DEV="C:\Users\hp\OneDrive\Bureau\projects\end-to-end-ELT-pipline\dbt-bigquery\credentials.json"
$env:LOCATION_DEV="EU"
$env:DBT_DATASET_PROD="translations_prod" 
$env:KEYPATH_PROD="C:\Users\hp\OneDrive\Bureau\projects\end-to-end-ELT-pipline\dbt-bigquery\credentials.json"
$env:LOCATION_PROD="EU"


### Docker build locally:
-docker build -t dbt_translations_marts .
##export variables:
-linux/MAC: export $(grep -v '^#' .env | xargs)
-windows: Get-Content .env | ForEach-Object {
    $name, $value = $_ -split '=', 2
    [System.Environment]::SetEnvironmentVariable($name.Trim(), $value.Trim(), [System.EnvironmentVariableTarget]::Process)
}

docker run --rm --env DBT_DATASET_DEV --env KEYPATH_DEV --env LOCATION_DEV --env PROJECT_ID dbt_translations_marts
# si tu veux charger toutes les variables en une seule commande:  docker run --rm --env-file .env dbt_translations_marts





