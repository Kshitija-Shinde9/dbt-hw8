# DATA226 Homework 8 — ELT Deep Dive with dbt + Snowflake

## Project Overview
This project demonstrates how to build an ELT pipeline using **dbt (data build tool)** with **Snowflake** as the data warehouse. It covers transform models, analytics models, snapshots, and data tests.

## Tech Stack
- dbt 1.11.8
- Snowflake (adapter: snowflake 1.11.4)
- Python 3.13.9
- GitHub for version control

## Snowflake Configuration
- **Account:** SFEDU02-EAB27764
- **Database:** USER_DB_FERRET
- **Warehouse:** FERRET_QUERY_WH
- **Role:** TRAINING_ROLE

## Project Structure

dbt_hw8/
├── models/
│   ├── transform/
│   │   ├── user_session_channel.sql   # CTE transform model
│   │   └── session_timestamp.sql      # CTE transform model
│   ├── analytics/
│   │   └── session_summary.sql        # Analytics table model
│   └── schema.yml                     # Data tests definition
├── snapshots/
│   └── snapshot_session_summary.sql   # SCD Type 2 snapshot
├── dbt_project.yml
└── README.md
## Steps Completed

### Step 1 — dbt Project with Snowflake Connector
- Initialized dbt project using `dbt init dbt_hw8`
- Configured Snowflake connector in `profiles.yml`
- Verified connection using `dbt debug` — All checks passed

### Step 2 — Transform Models (CTE)
- Created `models/transform/user_session_channel.sql`
- Created `models/transform/session_timestamp.sql`
- Both models materialized as **ephemeral** (CTE) via `dbt_project.yml`
- Ran `dbt run` — Found 2 models successfully

### Step 3 — Analytics Model
- Created `models/analytics/session_summary.sql`
- Joins `user_session_channel` and `session_timestamp` using `ref()`
- Materialized as a **table** in Snowflake analytics schema
- Ran `dbt run` — `1 of 1 OK created sql table model analytics.session_summary`

### Step 4 — Snapshot
- Created `snapshots/snapshot_session_summary.sql`
- Uses **timestamp strategy** on `ts` field with `sessionId` as unique key
- Ran `dbt snapshot` — `1 of 1 OK snapshotted snapshot.snapshot_session_summary`

### Step 5 — Data Tests
- Added 2 tests to `sessionId` field in `models/schema.yml`:
  - `not_null`
  - `unique`
- Ran `dbt test` — `PASS=2 WARN=0 ERROR=0 SKIP=0 TOTAL=2`

## How to Run

```bash
# Verify connection
dbt debug

# Run transform + analytics models
dbt run

# Run snapshot
dbt snapshot

# Run data tests
dbt test
```

## GitHub Repository
https://github.com/Kshitija-Shinde9/dbt-hw8

## Author
Kshitija Shinde
MS Data Science, San José State University
DATA226 — Data Warehouse | Spring 2026
