#!/bin/bash

csv_file="$1"
repository_name="$GITHUB_REPOSITORY"
workflow_run_id="$GITHUB_RUN_ID"
action_summary_link="${GITHUB_SERVER_URL}/${repository_name}/actions/runs/${workflow_run_id}"
dependencies_count=$(($(cat "$1" | wc -l) - 0))

construct_slack_message() {
    echo "{
        \"attachments\": [
            {
                \"blocks\": [
                    {
                        \"type\": \"header\",
                        \"text\": {
                            \"type\": \"plain_text\",
                            \"text\": \":warning:  $repository_name\"
                        }
                    }
                ]
            },
            {
                \"blocks\": [
                    {
                        \"type\": \"context\",
                        \"elements\": [
                            {
                                \"type\": \"mrkdwn\",
                                \"text\": \"*$dependencies_count licenses need to be reviewed*\\n\"
                            }
                        ]
                    },
                    {
                        \"type\": \"divider\"
                    },"

    dependencies=$(cat "$1" | tr -d '\r')
    first_line=true

    while IFS=',' read -r line; do
        name=$(echo "$line" | awk -F ',' '{gsub(/"/, "", $1); print $1}')
        license_type=$(echo "$line" | awk -F ',' '{gsub(/"/, "", $2); print $2}')
        dep_url=$(echo "$line" | awk -F ',' '{gsub(/"/, "", $3); print $3}')

        if [ "$first_line" = "true" ]; then
            first_line=false
        else
            echo ","
        fi

        IFS=';' read -ra licenses <<<"$license_type"
        license_text=""

        first_license=true
        for license in "${licenses[@]}"; do
            if [ "$first_license" = true ]; then
                license_text+="\\n•  $license"
                first_license=false
            else
                license_text+="\\n• $license"
            fi
        done

        echo "                {
                        \"type\": \"section\",
                        \"text\": {
                            \"type\": \"mrkdwn\",
                            \"text\": \" *<$dep_url|$name>*$license_text\"
                        }
                    }"
    done <<<"$dependencies"

    echo "            ]
            },"

    echo "        {
                \"color\": \"#87CEEB\",
                \"blocks\": [
                    {
                        \"type\": \"divider\"
                    },
                    {
                        \"type\": \"section\",
                        \"block_id\": \"section789\",
                        \"fields\": [
                            {
                                \"type\": \"mrkdwn\",
                                \"text\": \"GitHub Action summary: $action_summary_link\"
                            }
                        ]
                    }
                ]
            }"

    echo "    ]
    }"
}

if [ -z "$csv_file" ]; then
    echo "Usage: ./csv_to_text.sh <path_to_csv_file>"
    exit 1
fi

if [ ! -f "$csv_file" ]; then
    echo "Error: The specified CSV file does not exist."
    exit 1
fi

slack_data=$(construct_slack_message "$csv_file")
echo "$slack_data" >slack_message.json
