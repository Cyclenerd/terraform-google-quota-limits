#!/usr/bin/env bash

#
# Check CSV files and create a new issue on change
#
# Diff message based on https://stackoverflow.com/a/25498422
#

source "config.sh" || exit 9

MY_CHANGES=0

# GitHub Action runner
if [ -v GITHUB_RUN_ID ]; then
	echo "» Set git username and email"
	git config user.name "github-actions[bot]"
	git config user.email "41898282+github-actions[bot]@users.noreply.github.com"
fi

# Compute Engine
DIFF_QUOTAS_COMPUTE="/tmp/compute.txt"
if ! git diff --exit-code "$CSV_QUOTAS_COMPUTE"; then
	echo "'$CSV_QUOTAS_COMPUTE' changed!"
	{
		echo "Service quota metrics '$CSV_QUOTAS_COMPUTE' changed!"
		echo ""
		echo "Added:"
		git diff --color=always "$CSV_QUOTAS_COMPUTE" | perl -wlne 'print $1 if /^\e\[32m\+\e\[m\e\[32m(.*)\e\[m$/'
		echo ""
		echo "Deleted:"
		git diff --color=always "$CSV_QUOTAS_COMPUTE" | perl -wlne 'print $1 if /^\e\[31m-(.*)\e\[m$/'
	} > "$DIFF_QUOTAS_COMPUTE"
	echo "» Create a new incident to notify '$GITHUB_ISSUE_ASSIGNEE'."
	gh issue create --assignee "$GITHUB_ISSUE_ASSIGNEE" --title "Compute Engine metrics changed" -F "$DIFF_QUOTAS_COMPUTE"
	git add "$CSV_QUOTAS_COMPUTE"
	((MY_CHANGES++));
fi

# Cloud Storage
if ! git diff --exit-code "$CSV_QUOTAS_STORAGE"; then
	git add "$CSV_QUOTAS_STORAGE"
	((MY_CHANGES++));
fi

# BigQuery
if ! git diff --exit-code "$CSV_QUOTAS_BIGQUERY"; then
	git add "$CSV_QUOTAS_BIGQUERY"
	((MY_CHANGES++));
fi

# Commit and push
if [ "$MY_CHANGES" -ge 1 ]; then
	echo "Commit and push to repo..."
	git commit -m "Service quota metric changes" || exit 9
	git push || exit 9
fi

echo "DONE"