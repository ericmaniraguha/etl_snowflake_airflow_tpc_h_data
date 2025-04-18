# ETL Project README

## Overview
This project demonstrates an ELT (Extract, Load, Transform) pipeline using DBT for transformation, Snowflake as the data warehouse, and Airflow for orchestration. The project utilizes the TPC-H sample dataset available in Snowflake to build fact tables and data marts.

## Tools Used

### Core Technology Stack
- **DBT (Data Build Tool)**: Handles transformation logic within the data warehouse
- **Snowflake**: Cloud data warehouse platform
- **Airflow**: Workflow orchestration
- **Spark**: Big data processing engine

## Project Purpose
This pipeline demonstrates modern data engineering practices, focusing on:
- Building fact tables and data marts
- Implementing Snowflake RBAC (Role-Based Access Control)
- Configuring and deploying workflows to Airflow
- Leveraging DBT for SQL-based transformations

## Dataset
This project uses the TPC-H sample dataset provided by Snowflake, which simulates a realistic business data environment:
- [TPC-H Sample Data Documentation](https://docs.snowflake.com/en/user-guide/sample-data-tpch)

## Setup Instructions

### 1. Install DBT on Windows
```bash
pip install dbt
```

Verify the installation:
```bash
dbt --version
```

### 2. Setup Snowflake Environment
Login or signup for Snowflake: [https://www.snowflake.com/en/](https://www.snowflake.com/en/)

Configure warehouses, databases, and roles in Snowflake to support the ELT pipeline:

```sql
use role accountadmin;

create warehouse dbt_wh with warehouse_size = 'x-small';
create database if not exists dbt_db;
create role if not exists dbt_role;

show grants on warehouse dbt_wh;

grant usage on warehouse dbt_wh to role dbt_role;
grant role dbt_role to user ericmaniraguha;
grant all on database dbt_db to role dbt_role;

use role dbt_role;

create schema dbt_db.dbt_schema;

-- If you need to drop the warehouse later, use this approach:
-- use role accountadmin;
-- drop warehouse if exists dbt_wh;
-- drop database if exists dbt_db;
-- drop role if exists dbt_role;
```

### 3. Configure Python Environment
Create and activate a virtual environment:
```bash
python -m venv env
source env/Scripts/activate  # For Windows
```

Install required packages:
```bash
# Install DBT Core and Snowflake adapter
pip install dbt-core
pip install dbt-snowflake
```

Alternatively, use:
```bash
pip install -r requirements.txt  # Make sure you're in the activated environment
```

### 4. Initialize DBT Project
```bash
dbt init etl_project_tcp_h_data
```

### 5. Configure Snowflake Connection
During initialization, configure your database connection:
- Select database: `snowflake`
- Account: `https://mgxxxx.uae-north.azure.xxxxxxxxxxxxxxxxxxx.com`
- User: `ericmaniraguha`
- Authentication Type: `password`
- Role: `dbt_role`
- Warehouse: `dbt_wh`
- Database: `dbt_db`
- Schema: `dbt_schema`
- Threads: `10`

### 6. Set Up Project Structure
Verify project creation:
```bash
ls  # You should see etl_project_tcp_h_data/
```

Navigate to project directory:
```bash
cd etl_project_tcp_h_data/
```

Open in your IDE:
```bash
code .  # Opens in Visual Studio Code
```

### 7. Configure dbt_project.yml File
Update your configuration:
```yaml
# files using the `{{ config(...) }}` macro.
models:
  etl_project_tcp_h_data:
    # Config indicated by + and applies to all files under models/example/
    staging:
      +materialized: view
      snowflake_warehouse: dbt_wh
    marts:
      +materialized: table
      snowflake_warehouse: dbt_wh
```

### 8. Organize Models Directory
- Delete the example models
- Create new folders: `staging` and `marts` inside the models directory

### 9. Create Package Dependencies
Create a `packages.yml` file in the root directory:
```yaml
packages:
  # List of packages to install
  - package: dbt-labs/dbt_utils
    version: 1.9.4  # Check for latest version at https://github.com/dbt-labs/dbt-core