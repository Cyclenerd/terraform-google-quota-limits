#!/usr/bin/env bash

#
# Export all service quota metrics for a consumer (API)
#

source "config.sh" || exit 9

echo "Get quotas... Please wait..."

echo "METRIC,NAME" > "$CSV_QUOTAS_COMPUTE" || exit 9
gcloud alpha services quota list \
--quiet \
--service="compute.googleapis.com" \
--consumer="projects/$MY_PROJECT_ID" \
--format="csv[no-heading,separator=','](metric,displayName)" | sort -u >> "$CSV_QUOTAS_COMPUTE" || exit 9

echo "METRIC,NAME" > "$CSV_QUOTAS_STORAGE" || exit 9
gcloud alpha services quota list \
--quiet \
--service="storage.googleapis.com" \
--consumer="projects/$MY_PROJECT_ID" \
--format="csv[no-heading,separator=','](metric,displayName)" | sort -u >> "$CSV_QUOTAS_STORAGE" || exit 9

echo "METRIC,NAME" > "$CSV_QUOTAS_BIGQUERY" || exit 9
gcloud alpha services quota list \
--quiet \
--service="bigquery.googleapis.com" \
--consumer="projects/$MY_PROJECT_ID" \
--format="csv[no-heading,separator=','](metric,displayName)" | sort -u >> "$CSV_QUOTAS_BIGQUERY" || exit 9

echo "DONE"